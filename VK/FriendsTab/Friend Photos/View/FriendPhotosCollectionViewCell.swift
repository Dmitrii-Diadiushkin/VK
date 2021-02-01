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
    
    func setupCell() {
        self.contentView.addSubview(photoImage)
        
        NSLayoutConstraint.activate([
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        photoImage.image = UIImage(systemName: "house.fill")
    }
}
