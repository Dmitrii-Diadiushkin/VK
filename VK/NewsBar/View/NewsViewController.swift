//
//  NewsViewController.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 09.12.2020.
//

import UIKit

class NewsViewController: UIViewController {

    private lazy var testLabel: UILabel = {
        let testLabel = UILabel()
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return testLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(testLabel)
        
        testLabel.text = "My News"
        
        
        NSLayoutConstraint.activate([
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }


}
