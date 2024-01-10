//
//  WeatherInfoCellPresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//


import Foundation
import WeatherAPI

protocol WeatherInfoTablePresenterProtocol: AnyObject {
    func cellDidDequeue()
    func cellDidPrepareForReuse()
    func favoriteButtonDidTap()
}

final class WeatherInfoTablePresenter {
    
    unowned let view: WeatherInfoTableCellProtocol!
    let interactor: WeatherInfoTableCellInteractorProtocol
    
    let weatherData: WeatherData?
    
    init(
        view: WeatherInfoTableCellProtocol!,
        interactor: WeatherInfoTableCellInteractorProtocol,
        weatherData: WeatherData?
    ) {
        self.view = view
        self.interactor = interactor
        self.weatherData = weatherData
    }
    
}

extension WeatherInfoTablePresenter: WeatherInfoTablePresenterProtocol {
    
    func cellDidDequeue() {
        
        view.configure(
            cityText: weatherData?.city,
            countryText: weatherData?.country,
            temperatureText: "\(weatherData?.temperature ?? .zero)",
            weatherInfoText: weatherData?.weatherDescription,
            humidityText: weatherData?.humidity,
            windSpeedText: weatherData?.windSpeed
        )
        
        if interactor.isFavorite(weather: weatherData) {
            view.setButtonImage(systemName: "star.fill")
        } else {
            view.setButtonImage(systemName: "star")
        }
    }
    
    func cellDidPrepareForReuse() {
        view.resetSubviews()
    }
    
    func favoriteButtonDidTap() {
        
        if interactor.isFavorite(weather: weatherData) {
            interactor.removeFromFavorite(weather: weatherData)
            view.setButtonImage(systemName: "star")
        } else {
            interactor.addToFavorite(weather: weatherData)
            view.setButtonImage(systemName: "star.fill")
        }
    }
}

