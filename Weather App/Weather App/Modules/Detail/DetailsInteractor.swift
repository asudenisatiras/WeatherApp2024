//
//  DetailsInteractor.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import Foundation
import WeatherAPI
import Alamofire

protocol DetailsInteractorProtocol: AnyObject {
    func getFavorites() -> [WeatherData]
}

class DetailsInteractor {
    
    let userDefaultsService : UserDefaultsServiceProtocol
    init(userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService() ) {
        self.userDefaultsService = userDefaultsService
    }
}

extension DetailsInteractor:DetailsInteractorProtocol {
    func getFavorites() -> [WeatherAPI.WeatherData] {
        
        return userDefaultsService.getFavorites()
    }
}
