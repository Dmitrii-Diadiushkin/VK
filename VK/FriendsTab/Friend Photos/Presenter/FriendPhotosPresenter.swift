//
//  FriendPhotosPresenter.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 25.01.2021.
//

import Foundation
import UIKit

protocol FriendPhotosViewInput {
    func showAlbums(albumsToShow: [AlbumsVM])
}

protocol FriendPhotosViewOutput {
    func needDataToShow()
}

final class FriendPhotosPresenter {
    
    weak var viewInput: (UIViewController & FriendPhotosViewInput)?
    private let friendID: Int
    private let networkManager = NetworkManager.shared
    
    init(selectedFriendID: Int) {
        self.friendID = selectedFriendID
    }
    
    private func prepareData(albums: FriendsAlbums) -> [AlbumsVM] {
        var albumsToShow = [AlbumsVM]()
        for element in albums.albums {
            let elementToShow = AlbumsVM(id: element.id, name: element.title, thumb: element.thumbSrc)
            albumsToShow.append(elementToShow)
        }
        return albumsToShow
    }
}

extension FriendPhotosPresenter: FriendPhotosViewOutput {
    
    func needDataToShow() {
        networkManager.getFriendAlbums(friendID: friendID) { [weak self] result in
            switch result {
            case let .success(albums):
                guard let self = self else {return}
                let albumsToShow = self.prepareData(albums: albums)
                DispatchQueue.main.async {
                    self.viewInput?.showAlbums(albumsToShow: albumsToShow)
                }
                
            case.failure(_):
                print("Data error Album")
            }
        }
    }
    
    
}
