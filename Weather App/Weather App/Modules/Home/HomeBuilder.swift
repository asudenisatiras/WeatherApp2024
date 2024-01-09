//
//  HomeBuilder.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import WeatherAPI
import UIKit

enum HomeBuilder {
    static func createModule() -> HomeViewController {
    
      
        let view = HomeViewController()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        
        let presenter = HomePresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        
        interactor.output = presenter
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}

