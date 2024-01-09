//
//  MainTabBarBuilder.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation

import UIKit

enum MainTabBarBuilder {
    static func createModule() -> MainTabBarController {
    
      
        let tabBar = MainTabBarController()
        let homeVC = HomeBuilder.createModule()
        let favoriteVC = DetailsBuilder.createModule(nil)
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteVC)
        
        tabBar.viewControllers = [ homeNavigationController, favoriteNavigationController]
        
        return tabBar
    }
}

