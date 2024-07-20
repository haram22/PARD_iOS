//
//  ReasonController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

func getReason(completion: @escaping ([ReasonPardnerShip]) -> Void) {
    guard let urlLink = URL(string: url + "/reason") else {
        print("🚨 잘못된 URL")
        return
func getReason() {
    if let urlLink = URL(string: url + "/reason") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getReason] Error: No data or empty data")
                return
            }
            
            // 응답 데이터를 문자열로 변환하여 출력
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("🌱 Response Data String: \(dataString)")
            } else {
                print("🚨🚨 Error: Unable to convert data to string")
            }
            
            let decoder = JSONDecoder()
            do {
                // 먼저 JSON 데이터를 단일 객체로 디코딩 시도
                if let reason = try? decoder.decode(Reason.self, from: JSONdata) {
                    print("✅ Success: \(reason)")
                } else if let reasonArray = try? decoder.decode([Reason].self, from: JSONdata) {
                    ReasonManager.shared.reasonList = reasonArray
                    print("✅ Success: \(reasonArray)")
                } else {
                    print("🚨 Decoding Error: Unable to decode data")
                }
            } catch {
                print("🚨 Decoding Error:", error)
            }
        }
        task.resume()
    }
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: urlLink) { data, response, error in
        if let error = error {
            print("🚨 에러:", error)
            return
        }
        
        guard let JSONdata = data, !JSONdata.isEmpty else {
            print("🚨 [getReason] 에러: 데이터가 없거나 빈 데이터")
            return
        }
        
        if let dataString = String(data: JSONdata, encoding: .utf8) {
            print("🌱 응답 데이터 문자열: \(dataString)")
        } else {
            print("🚨 데이터를 문자열로 변환할 수 없음")
        }
        
        let decoder = JSONDecoder()
        do {
            if let reason = try? decoder.decode(ReasonPardnerShip.self, from: JSONdata) {
                print("✅ 성공: Reason")
                completion([reason])
            } else {
                let reasonArray = try decoder.decode([ReasonPardnerShip].self, from: JSONdata)
                print("✅ 성공: Reason")
                completion(reasonArray)
            }
        } catch {
            print("🚨 디코딩 에러:", error)
        }
    }
    
    task.resume()
}
