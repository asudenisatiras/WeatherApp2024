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
       
        let interactor = DetailsInteractor()
        
        let presenter = DetailsPresenter(
            view: view,
            interactor: interactor,
            weatherData: data
        )
        view.presenter = presenter
        return view
    }
}
