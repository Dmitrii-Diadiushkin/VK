//
//  FriendPhotosBuilder.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 25.01.2021.
//

import UIKit

final class FriendPhotosBuilder {
    static func build(selectedFriendID: Int) -> (UIViewController & FriendPhotosViewInput) {
        let presenter = FriendPhotosPresenter(selectedFriendID: selectedFriendID)
        let viewController = FriendPhotosViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
