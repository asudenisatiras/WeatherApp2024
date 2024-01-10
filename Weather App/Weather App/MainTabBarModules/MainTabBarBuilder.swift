//
//  MainTabBarBuilder.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.


import UIKit

enum MainTabBarBuilder {
    static func createModule() -> MainTabBarController {
        let tabBar = MainTabBarController()
        
        tabBar.tabBar.tintColor = UIColor(red: 175/255.0, green: 210/255.0, blue: 229/255.0, alpha: 1.0)
        
        let homeVC = HomeBuilder.createModule()
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeVC.tabBarItem = homeTabBarItem
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        
        let favoriteVC = FavoritesBuilder.createModule()
        let favoriteTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        favoriteVC.tabBarItem = favoriteTabBarItem
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteVC)
        
        tabBar.viewControllers = [homeNavigationController, favoriteNavigationController]
        
        return tabBar
    }
}
