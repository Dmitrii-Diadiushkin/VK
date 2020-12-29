//
//  TabBarViewController.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let friendsVC = FriendsModuleBuilder.build()
        friendsVC.title = "My Friends"
        let friendNC = UINavigationController(rootViewController: friendsVC)
        friendNC.tabBarItem = UITabBarItem(title: "Friends", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        let vc2 = MyGroupsViewController()
        vc2.title = "My Groups"
        let groupNC = UINavigationController(rootViewController: vc2)
        groupNC.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
        
        let vc3 = NewsViewController()
        vc3.title = "My News"
        let newsNC = UINavigationController(rootViewController: vc3)
        newsNC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        
        self.viewControllers = [friendNC, groupNC, newsNC]
    }

}
