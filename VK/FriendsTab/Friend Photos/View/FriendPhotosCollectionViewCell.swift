//
//  FriendPhotosCollectionViewCell.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 01.02.2021.
//

import UIKit

class FriendPhotosCollectionViewCell: UICollectionViewCell {
    private lazy var photoImage:UIImageView = {
        let photoImage = UIImageView()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        return photoImage
    }()
    
    func setupCell(albumToShow: AlbumsVM) {
        self.contentView.addSubview(photoImage)
        
        NSLayoutConstraint.activate([
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        let image = try? Data(contentsOf: URL(string: albumToShow.thumb)!)
        guard let thumb = image else {
            return photoImage.image = UIImage(systemName: "house.fill")
        }
        photoImage.image = UIImage(data: thumb)
    }
}
