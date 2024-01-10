//
//  UserDefaultsService.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import WeatherAPI
protocol UserDefaultsServiceProtocol: AnyObject {
    func isFavorite(weather: WeatherData?) -> Bool
    func addToFavorite(weather: WeatherData?)
    func removeFromFavorite(weather: WeatherData?)
    func getFavorites() -> [WeatherData]
}

class UserDefaultsService {
    let userDefaults = UserDefaults.standard
    static let favoriteCityKey = "favorites"
}

extension UserDefaultsService : UserDefaultsServiceProtocol {
    func getFavorites() -> [WeatherAPI.WeatherData] {
        guard let favoriteCities = userDefaults.data(forKey: Self.favoriteCityKey),
              let decodedFavoriteCities = try? JSONDecoder().decode([WeatherData].self, from: favoriteCities)
        else {
            return []
        }
        return decodedFavoriteCities
    }
    
    func isFavorite(weather: WeatherData?) -> Bool {
        guard let weather,
              let favoriteCities = userDefaults.data(forKey: Self.favoriteCityKey),
              let decodedFavoriteCities = try? JSONDecoder().decode([WeatherData].self, from: favoriteCities) else {
            return false
        }
        
        return decodedFavoriteCities.contains(where: {
            $0.city == weather.city
        })
    }
    
    func addToFavorite(weather: WeatherData?) {
        
        guard let weather else {
            return
        }
        
        if let  favoriteCities = userDefaults.data(forKey: Self.favoriteCityKey) {
            var decodedFavoriteCities = try? JSONDecoder().decode([WeatherData].self, from: favoriteCities)
            
            decodedFavoriteCities?.append(weather)
            
            let encodingFavoriteCities = try? JSONEncoder().encode(decodedFavoriteCities)
            
            userDefaults.set(encodingFavoriteCities, forKey: Self.favoriteCityKey)
        } else {
            let favoriteCities = [weather]
            let encodingFavoriteCities = try? JSONEncoder().encode(favoriteCities)
            
            userDefaults.set(encodingFavoriteCities, forKey: Self.favoriteCityKey)
        }
        
        
    }
    
    func removeFromFavorite(weather: WeatherData?) {
        
        guard let weather else {
            return
        }
        
        guard let  favoriteCities = userDefaults.data(forKey: Self.favoriteCityKey) else {
            return
        }
        var decodedFavoriteCities = try? JSONDecoder().decode([WeatherData].self, from: favoriteCities)
        
        decodedFavoriteCities?.removeAll(where: { $0.city == weather.city } )
        
        let encodingFavoriteCities = try? JSONEncoder().encode(decodedFavoriteCities)
        userDefaults.set(encodingFavoriteCities, forKey: Self.favoriteCityKey)
        
        
    }
    
}
