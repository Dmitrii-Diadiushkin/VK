//
//  FriendPhotosViewController.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 25.01.2021.
//

import UIKit

class FriendPhotosViewController: UIViewController {

    //MARK: - Declaration
    private var collectionView: UICollectionView?
    
    private let presenter: FriendPhotosPresenter
    private var albumsForView = [AlbumsVM]()
    
    //MARK: - Initialization
    init(presenter: FriendPhotosPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifetime functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.needDataToShow()
    }

    //MARK: - Functions
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let itemWidth = self.view.bounds.width / 2 - 5
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionViewLayout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView?.register(FriendPhotosCollectionViewCell.self, forCellWithReuseIdentifier: "FriendPhotoCell")
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView ?? UICollectionView())
    }

}

//MARK: - Extentions CollectionView

extension FriendPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Items: \(albumsForView.count)")
        return albumsForView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotosCollectionViewCell
        cell.setupCell(albumToShow: albumsForView[indexPath.row])
        return cell
    }
    
    
}

extension FriendPhotosViewController: UICollectionViewDelegate {
    
}

//MARK: - Extention Input Protocol
extension FriendPhotosViewController: FriendPhotosViewInput {
    func showAlbums(albumsToShow: [AlbumsVM]) {
        albumsForView = albumsToShow
        print("Update CollectionView")
        collectionView?.reloadData()
    }
    
}
