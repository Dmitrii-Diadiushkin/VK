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
    
    //MARK: - Initializations
    init(presenter: FriendsPresenter) {
        self.presenter = presenter
        super.init(nibName: "FriendsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifetime funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Funcs
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

    //MARK: - Extentions TableView
extension FriendsViewController: UITableViewDelegate {
    
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

    //MARK: - Extention Input Protocol
extension FriendsViewController: FriendsViewInput {
    
}
