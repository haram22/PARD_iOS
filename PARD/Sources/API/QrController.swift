//
//  QrController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

import UIKit

extension ReaderViewController {

    private struct AssociatedKeys {
        static var isModalShowing = "isModalShowing"
    }
    
    private var isModalShowing: Bool {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.isModalShowing) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isModalShowing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func getValidQR(with qrUrl: String) {
        print("❤️ \(qrUrl)")
        guard let url = URL(string: "\(url)/validQR") else {
            print("🚨 Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: AnyHashable] = [
            "qrUrl": qrUrl,
            "seminar": "1"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("🚨 Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ success: \(responseString)")
                
                DispatchQueue.main.async {
                    // 이미 모달이 표시된 경우, 중복 표시를 방지
                    if self.isModalShowing {
                        print("🚨 Modal is already showing, skipping")
                        return
                    }
                    self.isModalShowing = true
                    
                    self.handleResponse(responseString: responseString)
                }
                
            } else {
                print("🚨 Error: Unable to convert data to string")
            }
        }
        task.resume()
    }
    
    private func handleResponse(responseString: String) {
        let modalBuilder = ModalBuilder().add(title: "출석 체크")
        
        if responseString.contains("잘못된") {
            modalBuilder
                .add(content: "유효하지 않은 QR 코드입니다.\n다시 시도해주세요.")
                .add(button: .confirm(title: "확인", action: {
                    self.navigateToHome()
                }))
            
        } else if responseString.contains("이미") {
            modalBuilder
                .add(image: "alreadyAttendance")
                .add(button: .confirm(title: "세미나 입장하기", action: {
                    self.navigateToHome()
                }))
            
        } else if responseString.contains("false") {
            modalBuilder
                .add(image: "late")
                .add(button: .confirm(title: "다음부터 안그럴게요", action: {
                    self.navigateToHome()
                }))
            
        } else if responseString.contains("true") {
            modalBuilder
                .add(image: "complete")
                .add(button: .confirm(title: "세미나 입장하기", action: {
                    self.navigateToHome()
                }))
            
        } else {
            modalBuilder
                .add(content: "등록된 일정이 없습니다.")
                .add(button: .confirm(title: "확인", action: {
                    self.navigateToHome()
                }))
        }
        
        modalBuilder.show(on: self)
    }
    
    private func navigateToHome() {
        // 플래그 초기화
        self.isModalShowing = false
        
        // 메인 화면으로 이동
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(HomeTabBarViewController(), animated: false)
        }
    }
}
