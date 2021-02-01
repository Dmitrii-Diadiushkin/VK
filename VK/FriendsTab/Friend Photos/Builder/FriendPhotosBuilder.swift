//
//  FriendPhotosBuilder.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 25.01.2021.
//

import UIKit

final class FriendPhotosBuilder {
    static func build() -> (UIViewController & FriendPhotosViewInput) {
        let presenter = FriendPhotosPresenter()
        let viewController = FriendPhotosViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
