//
//  FavoritesBuilder.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import UIKit

enum FavoritesBuilder {
    
    static func createModule() -> FavoritesViewController {
        
        
        let view = FavoritesViewController()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        
        let presenter = FavoritesPresenter (
        view: view,
        router: router, interactor: interactor
        
        
        )
        
        view.presenter = presenter
        router.viewController = view 
        return view
        
    }
}
