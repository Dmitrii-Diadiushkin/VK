//
//  FriendsPresenter.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import Foundation
import UIKit

protocol FriendsViewInput {
    func showData(indexes: [String], friends: [[FriendsVM]])
}

protocol FriendsViewOutput {
    func needDataToShow()
}

final class FriendsPresenter {
    
    weak var viewInput: (UIViewController & FriendsViewInput)?
    private let networkManager = NetworkManager.shared
    private var friendsToShow = [[FriendsVM]]()
   
    private func prepateDataToShow(friends: Friends) -> (friendsIndexes: [String], friendsToShow: [[FriendsVM]]) {
        var baseFriends = [FriendsVM]()
        for friend in friends.friends {
            let item = FriendsVM(id: friend.id, name: (friend.firstName + " " + friend.lastName), photo: friend.photo)
            baseFriends.append(item)
        }
        
        let friendsDict = Dictionary(grouping: baseFriends) { element -> String in
            return String(element.name.prefix(1))
        }
        
        let friendsIndexes = friendsDict.keys.sorted()
        friendsToShow = [[FriendsVM]]()
        
        friendsIndexes.forEach { key in
            if let friendForKey = friendsDict[key] {
                friendsToShow.append(friendForKey)
            }
        }
        
        return (friendsIndexes, friendsToShow)
    }
}

extension FriendsPresenter: FriendsViewOutput {
    func needDataToShow() {
        
        networkManager.getFriends() { [weak self] result in
            switch result {
            case let .success(friends):
                guard let self = self else {return}
                
                let dataToShow = self.prepateDataToShow(friends: friends)
                DispatchQueue.main.async {
                    self.viewInput?.showData(indexes: dataToShow.friendsIndexes, friends: dataToShow.friendsToShow)
                }
                
            case .failure(_):
                print("Data error")
            }
        }
    }
    
}
