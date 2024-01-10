//
//  FavoritesPresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import WeatherAPI
import UIKit
protocol FavoritesPresenterProtocol : AnyObject {
    func didSelectCell(at index : Int)
    func weatherData(at index: Int) -> WeatherData?
    var dataCount: Int { get }
    func setWeatherData(_ data: [WeatherData])
}

final class FavoritesPresenter {
    var weatherData: [WeatherData] = []
    
    unowned let view: FavoritesViewControllerProtocol
    let router: FavoritesRouterProtocol
    let interactor: FavoritesInteractorProtocol
    init(view: FavoritesViewControllerProtocol, router: FavoritesRouterProtocol, interactor: FavoritesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}
extension FavoritesPresenter : FavoritesPresenterProtocol {
    var dataCount: Int {
       weatherData.count
    }
    func weatherData(at index: Int) -> WeatherAPI.WeatherData? {
        guard index >= 0, index < weatherData.count else {
            return nil
        }
        return weatherData[index]
    }

    func setWeatherData(_ data: [WeatherData]) {
        weatherData = data
    }

    func didSelectCell(at index: Int) {
        let selectedWeatherData = weatherData(at: index)
        print("Selected Weather Data: \(selectedWeatherData)")
        router.navigateToDetail(selectedWeatherData)
    }

    
    
}
