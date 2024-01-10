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
    func startListeningUpdates()
    
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func weatherDataResult(_ data: [WeatherData])
    func weatherDataFetchError(_ errorMessage: String)
    func favoritesDidUpdate()
}

final class HomeInteractor {
    let weatherService: WeatherServiceProtocol
    unowned var output: HomeInteractorOutputProtocol!
    let userDefaultsService : UserDefaultsServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService(),userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService()) {
        self.weatherService = weatherService
        self.userDefaultsService = userDefaultsService
    }
    
    @objc private func didUpdateFavorites() {
        output.favoritesDidUpdate()
    }
    
    private func handleWeatherResponse(result: Result<[WeatherData], Error> ) {
        switch result {
        case .success(let data):
            self.output.weatherDataResult(data)
            userDefaultsService.saveData(data)
        case .failure(_ ):
            self.output.weatherDataResult(userDefaultsService.getAllData())
        }
    }
}
extension HomeInteractor: HomeInteractorProtocol {
    func downloadWeatherData(_ searchText: String?) {
        if let query = searchText, !query.isEmpty {
            
            weatherService.fetchWeather(city: query) { [weak self] result in
                guard let self = self else { return }
                handleWeatherResponse(result: result)
                
            }
        } else {
            weatherService.fetchWeather(city: "") { [weak self] result in
                guard let self = self else { return }
               handleWeatherResponse(result: result)
            }
        }
    }
    func startListeningUpdates() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateFavorites), name: .didUpdateFavorites, object: nil)
    }
}

