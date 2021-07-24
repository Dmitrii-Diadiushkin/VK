//
//  FriendPhotosBuilder.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 25.01.2021.
//

import UIKit

final class FriendAlbumsBuilder {
    static func build(selectedFriendID: Int) -> (UIViewController & FriendAlbumsViewInput) {
        let presenter = FriendAlbumsPresenter(selectedFriendID: selectedFriendID)
        let viewController = FriendAlbumsViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
