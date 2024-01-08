//
//  HomeInteractor.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import Foundation
import WeatherAPI
import Alamofire
protocol HomeInteractorProtocol: AnyObject {
    func downloadWeatherData(_ searchText: String?)
   
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func weatherDataResult(_ data: [WeatherData])
    func weatherDataFetchError(_ errorMessage: String)
}

final class HomeInteractor {
    let weatherService: WeatherServiceProtocol
    unowned var output: HomeInteractorOutputProtocol!
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
}
extension HomeInteractor: HomeInteractorProtocol {
    func downloadWeatherData(_ searchText: String?) {
        // If searchText is nil or empty, load all data
        if let query = searchText, !query.isEmpty {
            // Perform search with query
            weatherService.fetchWeather(city: query) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let data):
                    // Notify the output with the weather data
                    self.output.weatherDataResult(data)
                case .failure(let error):
                    // Notify the output about the error
                    self.output.weatherDataFetchError("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        } else {
            // Fetch all data
            weatherService.fetchWeather(city: "") { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let data):
                    // Notify the output with the weather data
                    self.output.weatherDataResult(data)
                case .failure(let error):
                    // Notify the output about the error
                    self.output.weatherDataFetchError("Error fetching weather data: \(error.localizedDescription)")
                }
            }
        }
    }


}

