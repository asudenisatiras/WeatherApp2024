//
//  FavoritesRouter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import UIKit
import WeatherAPI

protocol FavoritesRouterProtocol: AnyObject {
    func navigateToDetail( _ data: WeatherData?)
}

final class FavoritesRouter {
    unowned var viewController: UIViewController!
}

extension FavoritesRouter: FavoritesRouterProtocol {
    func navigateToDetail(_ data: WeatherData?) {
           let detailsVC = DetailsBuilder.createModule(data)
           viewController.navigationController?.pushViewController(detailsVC, animated: true)
       }
}
