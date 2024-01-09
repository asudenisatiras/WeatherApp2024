//
//  DetailsBuilder.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import WeatherAPI
import UIKit

enum DetailsBuilder {
    static func createModule(_ data: WeatherData?) -> DetailsViewController {
        
        let view = DetailsViewController()
        let router = DetailsRouter()
        let interactor = DetailsInteractor()
        
        let presenter = DetailsPresenter(
            view: view,
            router: router,
            interactor: interactor,
            weatherData: data
        )
        
        
        view.presenter = presenter
        router.viewController = view

        return view
    }
}
