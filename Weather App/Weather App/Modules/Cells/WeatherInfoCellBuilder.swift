//
//  WeatherInfoCellBuilder.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import WeatherAPI

enum WeatherInfoTableCellBuilder {
    static func createModule(
        cell: WeatherInfoTableCell,
        data: WeatherData?
    ) {
        let interactor = WeatherInfoTableCellInteractor()
        let presenter = WeatherInfoTablePresenter(
            view: cell,
            interactor: interactor,
            weatherData: data
        )
        
        cell.presenter = presenter
    }
}

