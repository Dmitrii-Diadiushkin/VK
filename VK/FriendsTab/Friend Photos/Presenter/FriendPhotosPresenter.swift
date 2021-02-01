//
//  FriendPhotosPresenter.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 25.01.2021.
//

import Foundation
import UIKit

protocol FriendPhotosViewInput {
    
}

protocol FriendPhotosViewOutput {
    
}

final class FriendPhotosPresenter {
    weak var viewInput: (UIViewController & FriendPhotosViewInput)?
}

extension FriendPhotosPresenter: FriendPhotosViewOutput {
    
}
