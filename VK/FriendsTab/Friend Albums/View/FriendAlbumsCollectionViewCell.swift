//
//  FriendPhotosCollectionViewCell.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 01.02.2021.
//

import UIKit

class FriendAlbumsCollectionViewCell: UICollectionViewCell {
    private lazy var albumImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.contentMode = .scaleAspectFit
        return photoImage
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func setupCell(albumToShow: AlbumsVM) {
        self.contentView.addSubview(albumImage)
        self.contentView.addSubview(albumNameLabel)
        
        NSLayoutConstraint.activate([
            albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
            albumImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
            albumImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0)
        ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
            albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
            albumNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 10.0),
            albumNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5.0)
        ])
        
        let image = try? Data(contentsOf: URL(string: albumToShow.thumb)!)
        guard let thumb = image else {
            return albumImage.image = UIImage(systemName: "house.fill")
        }
        albumImage.image = UIImage(data: thumb)
        albumNameLabel.text = albumToShow.name
    }
}
