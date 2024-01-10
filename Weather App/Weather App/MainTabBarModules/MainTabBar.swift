//
//  MainTabBar.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.itemPositioning = .automatic
        tabBar.itemWidth = tabBar.frame.width / CGFloat(tabBar.items?.count ?? 1)
        
        addSeparator()
    }
    
    func addSeparator() {
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        
        tabBar.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: tabBar.topAnchor),
            separatorView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -20),
            separatorView.widthAnchor.constraint(equalToConstant: 2),
            separatorView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor)
        ])
    }
}
