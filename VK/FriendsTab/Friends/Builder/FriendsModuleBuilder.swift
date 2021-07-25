//
//  FriendsModuleBuilder.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 29.12.2020.
//

import UIKit

final class FriendsModuleBuilder {
    static func build() -> (UIViewController & FriendsViewInput) {
        let presenter = FriendsPresenter()
        let viewController = FriendsViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
