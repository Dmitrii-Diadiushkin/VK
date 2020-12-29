//
//  FriendsPresenter.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import Foundation
import UIKit

protocol FriendsViewInput {
    
}

protocol FriendsViewOutput {
    
}

final class FriendsPresenter {
    weak var viewInput: (UIViewController & FriendsViewInput)?
}

extension FriendsPresenter: FriendsViewOutput {
    
}
