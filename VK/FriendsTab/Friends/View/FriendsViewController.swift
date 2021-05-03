//
//  FriendsViewController.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import UIKit

class FriendsViewController: UIViewController {
    
    //MARK: - Declaration
    @IBOutlet private weak var tableView: UITableView!
    
    private let presenter: FriendsPresenter
    private var friendsIndexes = [String]()
    private var friendsToShow = [[FriendsVM]]()
    
    //MARK: - Initializations
    init(presenter: FriendsPresenter) {
        self.presenter = presenter
        super.init(nibName: "FriendsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifetime functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.needDataToShow()
    }
    
    //MARK: - Funcs
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        tableView.tableFooterView = UIView()
    }
}

    //MARK: - Extentions TableView
extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFriendID = friendsToShow[indexPath.section][indexPath.row].id
        print("Selected friendID: \(selectedFriendID)")
        presenter.rowSelected(friendID: selectedFriendID)
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsIndexes.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsIndexes
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsIndexes[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsToShow[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendsTableViewCell
        
        let friendToShow = friendsToShow[indexPath.section][indexPath.row]
        
        cell.setUp(friend: friendToShow)
        
        return cell
    }
}

    //MARK: - Extention Input Protocol
extension FriendsViewController: FriendsViewInput {
    func showData(indexes: [String], friends: [[FriendsVM]]) {
        friendsIndexes = indexes
        friendsToShow = friends
        tableView.reloadData()
    }
    
}
