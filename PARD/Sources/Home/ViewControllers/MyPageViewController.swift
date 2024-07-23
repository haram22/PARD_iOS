//
//  MyPageViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//

import UIKit
import PARD_DesignSystem
import GoogleSignIn

class MyPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedbackView.layer.sublayers?.first?.frame = feedbackView.bounds
    }
    
    
    private func setupUI() {
        view.addSubview(myPageLabel)
        
        view.addSubview(feedbackView)
        feedbackView.addSubview(feedbackLabel)
        feedbackView.layer.insertSublayer(gradientLayer(), at: 0)
        feedbackView.addSubview(feedbackActionLabel)
        feedbackView.addSubview(feedbackActionView)
        feedbackActionView.addSubview(feedbackActionLabel)
        feedbackActionView.addSubview(feedbackArrowImageView)
        feedbackActionView.addSubview(feedbackArrowImageView2)
        
        view.addSubview(infoView)
        infoView.addSubview(statusStackView)
        view.addSubview(infoLabel)
        
        statusLabel1.sizeToFit()
        statusLabel2.sizeToFit()
        statusLabel3.sizeToFit()
        
        statusLabel2.backgroundColor = UIColor(patternImage: gradientImage())
        statusStackView.addArrangedSubview(statusLabel1)
        statusStackView.addArrangedSubview(statusLabel2)
        statusStackView.addArrangedSubview(statusLabel3)
        view.addSubview(nameLabel)
        
        view.addSubview(settingsLabel)
        view.addSubview(notificationSettingView)
        notificationSettingView.addSubview(notificationSettingLabel)
        notificationSettingView.addSubview(notificationSwitch)
        
        view.addSubview(usageGuideLabel)
        view.addSubview(usageGuideView)
        usageGuideView.addSubview(privacyPolicyLabel)
        usageGuideView.addSubview(termsOfServiceLabel)
        usageGuideView.addSubview(personalInfoArrowView)
        usageGuideView.addSubview(serviceInfoArrowView)
        usageGuideView.addSubview(personalInfoArrowButton)
        usageGuideView.addSubview(serviceInfoArrowButton)
        
        view.addSubview(accountLabel)
        view.addSubview(accountView)
        accountView.addSubview(logoutLabel)
        accountView.addSubview(deleteAccountLabel)
        
        accountView.addSubview(logoutArrowView)
        accountView.addSubview(deleteAccountArrowView)
        accountView.addSubview(logoutArrowButton)
        accountView.addSubview(deleteAccountArrowButton)
    }
    
    private func setupConstraints() {
        myPageLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(58)
            make.left.equalTo(view.snp.left).offset(151)
            make.right.equalTo(view.snp.right).offset(-151)
        }
        
        feedbackView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(76)
            make.top.equalTo(myPageLabel.snp.bottom).offset(26)
        }
        
        feedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(feedbackView.snp.top).offset(16)
            make.leading.equalTo(feedbackView.snp.leading).offset(24)
            make.bottom.equalTo(feedbackView.snp.bottom).offset(-16)
        }
        
        feedbackActionLabel.snp.makeConstraints { make in
            make.leading.equalTo(feedbackView.snp.leading).offset(290)
            make.top.equalTo(feedbackActionView.snp.top).offset(31)
            make.bottom.equalTo(feedbackActionView.snp.bottom).offset(-31)
        }
        
        
        feedbackActionView.snp.makeConstraints { make in
            make.trailing.equalTo(feedbackView.snp.trailing).offset(-24)
            make.centerY.equalTo(feedbackView.snp.centerY)
        }
        
        
        feedbackArrowImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.leading.equalTo(feedbackView.snp.leading).offset(357)
            make.top.equalTo(feedbackActionView.snp.top).offset(33)
            make.bottom.equalTo(feedbackActionView.snp.bottom).offset(-33)

        }
        
        feedbackArrowImageView2.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.leading.equalTo(feedbackView.snp.leading).offset(363)
            make.top.equalTo(feedbackActionView.snp.top).offset(33)
            make.bottom.equalTo(feedbackActionView.snp.bottom).offset(-33)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(236)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoView.snp.top).offset(-8)
            make.leading.equalTo(infoView.snp.leading)
        }
        
        statusStackView.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.top).offset(20)
            make.leading.equalTo(infoView.snp.leading).offset(24)
            make.bottom.equalTo(infoView.snp.bottom).offset(-52)
        }
        
        statusLabel1.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(42)
            
        }
        
        statusLabel2.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(66)
            
        }
        
        statusLabel3.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(66)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.top).offset(52)
            make.leading.equalTo(infoView.snp.leading).offset(24)
            make.bottom.equalTo(infoView.snp.bottom).offset(-20)
        }
        
        settingsLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(24)
            make.leading.equalTo(infoView.snp.leading)
        }
        
        notificationSettingView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(388)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        
        notificationSettingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(notificationSettingView)
            make.leading.equalTo(notificationSettingView.snp.leading).offset(24)
            make.top.equalTo(notificationSettingView.snp.top).offset(16)
            make.bottom.equalTo(notificationSettingView.snp.bottom).offset(-16)
            
        }
        
        notificationSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(notificationSettingLabel.snp.centerY)
            make.trailing.equalTo(notificationSettingView.snp.trailing).offset(-24)
        }
        
        usageGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationSettingView.snp.bottom).offset(24)
            make.leading.equalTo(infoView.snp.leading)
        }
        
        usageGuideView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(494)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        
        privacyPolicyLabel.snp.makeConstraints { make in
            make.top.equalTo(usageGuideView.snp.top).offset(17)
            make.leading.equalTo(usageGuideView.snp.leading).offset(24)
            make.bottom.equalTo(usageGuideView.snp.bottom).offset(-61)
        }
        
        termsOfServiceLabel.snp.makeConstraints { make in
            make.top.equalTo(usageGuideView.snp.top).offset(61)
            make.leading.equalTo(usageGuideView.snp.leading).offset(24)
            make.bottom.equalTo(usageGuideView.snp.bottom).offset(-17)
            
        }
        
        personalInfoArrowView.snp.makeConstraints { make in
            make.centerY.equalTo(privacyPolicyLabel)
            make.trailing.equalTo(usageGuideView.snp.trailing).offset(-24)
        }
        
        serviceInfoArrowView.snp.makeConstraints { make in
            make.centerY.equalTo(termsOfServiceLabel)
            make.trailing.equalTo(usageGuideView.snp.trailing).offset(-24)
        }
        
        personalInfoArrowButton.snp.makeConstraints { make in
            make.edges.equalTo(personalInfoArrowView).inset(-10)
        }
        
        serviceInfoArrowButton.snp.makeConstraints { make in
            make.edges.equalTo(serviceInfoArrowView).inset(-10)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(usageGuideView.snp.bottom).offset(24)
            make.leading.equalTo(infoView.snp.leading)
        }
        
        accountView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(646)
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
        
        logoutLabel.snp.makeConstraints { make in
            make.top.equalTo(accountView.snp.top).offset(17)
            make.leading.equalTo(accountView.snp.leading).offset(24)
            make.bottom.equalTo(accountView.snp.bottom).offset(-61)
        }
        
        deleteAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(accountView.snp.top).offset(61)
            make.leading.equalTo(accountView.snp.leading).offset(24)
            make.bottom.equalTo(accountView.snp.bottom).offset(-17)
        }
        
        logoutArrowView.snp.makeConstraints { make in
            make.centerY.equalTo(logoutLabel)
            make.trailing.equalTo(accountView.snp.trailing).offset(-24)
        }
        
        logoutArrowButton.snp.makeConstraints { make in
            make.edges.equalTo(logoutArrowView).inset(-10)
        }
        
        deleteAccountArrowView.snp.makeConstraints { make in
            make.centerY.equalTo(deleteAccountLabel)
            make.trailing.equalTo(accountView.snp.trailing).offset(-24)
        }
        deleteAccountArrowButton.snp.makeConstraints { make in
            make.edges.equalTo(deleteAccountArrowView).inset(-10)
        }
    }
    
    private func setupGestureRecognizers() {
        let feedbackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(feedbackViewTapped))
        feedbackView.addGestureRecognizer(feedbackTapGestureRecognizer)
        feedbackView.isUserInteractionEnabled = true
        
        personalInfoArrowButton.addTarget(self, action: #selector(personalInfoTapped), for: .touchUpInside)
        serviceInfoArrowButton.addTarget(self, action: #selector(aboutServiceTapped), for: .touchUpInside)
        logoutArrowButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        deleteAccountArrowButton.addTarget(self, action: #selector(deleteAccountTapped), for: .touchUpInside)
    }
    
    @objc private func feedbackViewTapped() {
        if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfFMK14a9BwcRPR2z6uuhQ_Cleg0povmGpcJwpAMLm-nWYp7A/viewform") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func personalInfoTapped() {
        if let url = URL(string: "https://www.notion.so/we-pard/Pard-APP-fc37c472e47941d3958765587b57e21f") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func aboutServiceTapped() {
        if let url = URL(string: "https://www.notion.so/we-pard/Pard-APP-74f6a4d8383d4e4993f28e9463b0d9b0") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func logoutTapped() {
        print("logout tapped")
        ModalBuilder()
            .add(title: "로그아웃")
            .add(content: "로그아웃 하시겠습니까?")
            .add(button: .cancellable(
                cancelButtonTitle: "취소",
                confirmButtonTitle: "확인",
                cancelButtonAction: .none,
                confirmButtonAction: {
                    // 구글 로그아웃
                    GIDSignIn.sharedInstance.signOut()
                    GIDSignIn.sharedInstance.disconnect()
                    print("User has been logged out")
                    
                    self.clearUserDefaults {
                        // 로그인 화면으로 다시 돌아가기
                        DispatchQueue.main.async {
                            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                                sceneDelegate.setRootViewController()
                            }
                        }
                    }
                }))
            .show(on: self)
    }
    
    // UserDefaults에 있는 값 모두 삭제하기
    private func clearUserDefaults(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            let defaults = UserDefaults.standard
            if let appDomain = Bundle.main.bundleIdentifier {
                defaults.removePersistentDomain(forName: appDomain)
            }
            
            // 모든 UserDefaults를 명시적으로 동기화
            defaults.synchronize()
            print("All UserDefaults have been cleared")
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    @objc private func deleteAccountTapped() {
        print("deleteAccount tapped")
        ModalBuilder()
            .add(title: "회원 탈퇴")
            .add(content: "회원 탈퇴 후 개인정보, 점수 등의\n데이터가 삭제되며 복구할 수 없습니다.\n정말 삭제하시겠습니까?")
            .add(button: .cancellable(cancelButtonTitle: "취소", confirmButtonTitle: "확인", cancelButtonAction: .none, confirmButtonAction: {
                self.deleteUser(userEmail: userEmail)
                
                // 구글 로그아웃
                GIDSignIn.sharedInstance.signOut()
                GIDSignIn.sharedInstance.disconnect()
                
                // userDefault에 있는 정보 모두 clear
                self.clearUserDefaults()
                
                // 로그인 화면으로 다시 돌아가기
                DispatchQueue.main.async {
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.setRootViewController()
                    }
                }
            }))
            .show(on: self)
    }
    
    private func clearUserDefaults() {
        DispatchQueue.main.async {
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
                UserDefaults.standard.synchronize() // 명시적으로 동기화 수행
                print("All UserDefaults have been cleared")
            }
        }
    }
    
    private func deleteUser(userEmail: String) {
        print("User \(userEmail) deleted.")
    }
    
    private let myPageLabel: UILabel = {
        let myPageLabel = UILabel()
        myPageLabel.text = "마이 페이지"
        myPageLabel.textColor = .white
        myPageLabel.font = UIFont.pardFont.head2
        myPageLabel.textAlignment = .center
        
        return myPageLabel
    }()
    
    private let feedbackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1)
        return view
    }()
    
    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "운영진에게 전달하고 싶은 의견이 있나요?\n피드백 창구를 활용해보세요!"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        if let pretendardFont = UIFont(name: "Pretendard-SemiBold", size: 14) {
            label.font = pretendardFont
        } else {
            label.font = UIFont.pardFont.body4
        }
        return label
    }()
    
    
    private let feedbackActionLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 남기기"
        label.textColor = .pard.gray10
        
        label.textAlignment = .center
        label.font = UIFont.pardFont.body1
        return label
    }()
    
    private let feedbackArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let feedbackArrowImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let feedbackActionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.pard.primaryBlue.cgColor
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let infoLabel: UILabel = {
        let infolabel = UILabel()
        infolabel.text = "내 정보"
        infolabel.textColor = .white
        infolabel.textAlignment = .left
        infolabel.font = UIFont.pardFont.head1
        
        return infolabel
    }()
    
    private let statusLabel1: UILabel = {
        let label = UILabel()
        label.text = "\(userGeneration)기"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.pardFont.body2
        label.backgroundColor = UIColor.pard.primaryBlue
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()
    
    private let statusLabel2: UILabel = {
        let label = UILabel()
        label.text = userPart
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.pardFont.body2
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()
    
    private let statusLabel3: UILabel = {
        let label = UILabel()
        label.text = userRole
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.pardFont.body2
        label.backgroundColor = UIColor.pard.primaryPurple
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()
    
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(userName) 님"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.head1
        return label
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.head1
        
        return label
    }()
    
    private let notificationSettingView: UIView = {
        let view = UIView()
        view.backgroundColor = .pard.blackCard
        
        return view
    }()
    
    private let notificationSettingLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 설정"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.body4
        
        return label
    }()
    
    private let notificationSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1)
        toggleSwitch.addTarget(self, action: #selector(openNotificationSettings), for: .touchUpInside)
        return toggleSwitch
    }()
    
    @objc private func notificationSwitchChanged() {
        
        if notificationSwitch.isOn {
            openNotificationSettings()
        } else {
            print("Notifications disabled")
        }
    }
    
    
    @objc private func openNotificationSettings() {
        
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }
    
    private let usageGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 안내"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.head1
        label.font = UIFont.pardFont.head1
        
        return label
    }()
    
    private let usageGuideView: UIView = {
        let view = UIView()
        view.backgroundColor = .pard.blackCard
        
        return view
    }()
    
    private let privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 처리방침"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.body4
        
        return label
    }()
    
    private let termsOfServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용약관"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.body4
        
        return label
    }()
    
    private let personalInfoArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let serviceInfoArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let personalInfoArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private let serviceInfoArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.head1
        return label
    }()
    
    private let accountView: UIView = {
        let view = UIView()
        view.backgroundColor = .pard.blackCard
        return view
    }()
    
    private let logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.body4
        
        return label
    }()
    
    private let deleteAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴하기"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.pardFont.body4
        
        return label
    }()
    
    private let logoutArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let deleteAccountArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let logoutArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private let deleteAccountArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    func gradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1).cgColor,
            UIColor(red: 123/255, green: 63/255, blue: 239/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        return gradientLayer
    }
    
    private func gradientImage() -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        gradientLayer.colors = [UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1).cgColor, UIColor(red: 123/255, green: 63/255, blue: 239/255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
