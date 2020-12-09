//
//  LoginModuleBulder.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import UIKit

final class LoginModuleBulder {
    static func build() -> (UIViewController & LoginViewInput) {
        let presenter = LoginPresenter()
        let viewController = LoginViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
