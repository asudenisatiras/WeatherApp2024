//
//  FavoritesInteractor.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import WeatherAPI
protocol FavoritesInteractorProtocol: AnyObject {
    func removeFromFavorites(data: WeatherData) -> [WeatherData]
    func getFavorites() -> [WeatherData]
    
}

class FavoritesInteractor {
    let userDefaultsService : UserDefaultsServiceProtocol
    init(userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService
        
    }
    
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    func getFavorites() -> [WeatherAPI.WeatherData] {
        userDefaultsService.getFavorites()
    }
    
    func removeFromFavorites(data: WeatherData) -> [WeatherData] {
        userDefaultsService.removeFromFavorite(weather: data)
        NotificationCenter.default.post(name: .didUpdateFavorites, object: nil)
        return userDefaultsService.getFavorites()
    }
    
    
}
