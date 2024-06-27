//
//  GoogleLoginManager.swift
//  PARD
//
//  Created by 김하람 on 6/27/24.
//

import Foundation
import GoogleSignIn

extension MainLoginViewController {
    @objc func handleGoogleLogin() {
        let signInConfig = GIDConfiguration.init(clientID: "215579567587-3qckigpku02urbubjtq4qd9oonpltkt3.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let emailAddress = user.profile?.email
            print("email Address = \(String(describing: emailAddress))")
            let fullName = user.profile?.name
            print("fullName = \(String(describing: fullName))")
            let givenName = user.profile?.givenName
            print("givenName = \(String(describing: givenName))")
            let familyName = user.profile?.familyName
            print("familyName = \(String(describing: familyName))")
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print("profilePicUrl = \(String(describing: profilePicUrl))")
            
            let userInfoPolicyViewController = UserInfoPolicyViewController()
            self.navigationController?.pushViewController(userInfoPolicyViewController, animated: true)
        }
    }
}
