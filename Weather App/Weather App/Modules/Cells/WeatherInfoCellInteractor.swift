//
//  WeatherInfoCellInteractor.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import WeatherAPI

protocol WeatherInfoTableCellInteractorProtocol: AnyObject {
    func isFavorite(weather: WeatherData?) -> Bool
    func addToFavorite(weather: WeatherData?)
    func removeFromFavorite(weather: WeatherData?)
}

final class WeatherInfoTableCellInteractor {
    
    let service : UserDefaultsServiceProtocol
    
    init(service: UserDefaultsServiceProtocol = UserDefaultsService()) {
        self.service = service
    }
    
}

extension WeatherInfoTableCellInteractor: WeatherInfoTableCellInteractorProtocol {
    
    func isFavorite(weather: WeatherData?) -> Bool {
        service.isFavorite(weather: weather)
    }
    
    func addToFavorite(weather: WeatherData?) {
        service.addToFavorite(weather: weather)
       
        
    }
    
    func removeFromFavorite(weather: WeatherData?) {
        service.removeFromFavorite(weather: weather)
    }
}

