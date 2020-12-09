//
//  LoginPresenter.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import UIKit
import WebKit

protocol LoginViewInput {
    func showError(error: String)
}

protocol LoginViewOutput {
    func serverResponce(responce: WKNavigationResponse)
}

final class LoginPresenter {
    
    weak var viewInput: (UIViewController & LoginViewInput)?
    
}

extension LoginPresenter: LoginViewOutput {
    func serverResponce(responce: WKNavigationResponse) {
        guard let url = responce.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            self.viewInput?.showError(error: "Response is corrupted")
            print("Response is corrupted")
            return
        }
        
        let parameters = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=")}.reduce([String: String]()) {result, parameter in
            var dict = result
            let key = parameter[0]
            let value = parameter[1]
            dict[key] = value
            return dict
        }
        
        guard let token = parameters["access_token"],
              let userIdString = parameters["user_id"],
              let userId = Int(userIdString) else {
            self.viewInput?.showError(error: "Response is corrupted")
            print("Response is corrupted")
            return
        }
        
        VKSession.shared.token = token
        VKSession.shared.userID = userId
        print("Show TabBar")
    }
    
}
