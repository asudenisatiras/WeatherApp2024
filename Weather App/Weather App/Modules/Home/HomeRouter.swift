//
//  HomeRouter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//


import Foundation
import UIKit
import WeatherAPI

protocol HomeRouterProtocol: AnyObject {
    func navigateToDetail(_ data: WeatherData?)
}

final class HomeRouter {
    unowned var viewController: UIViewController!
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigateToDetail(_ data: WeatherData?) {
        
        let detailsViewController = DetailsBuilder.createModule(data)
        
        viewController.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
