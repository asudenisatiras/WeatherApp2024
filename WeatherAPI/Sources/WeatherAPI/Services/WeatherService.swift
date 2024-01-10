//
//  WeatherService.swift
//
//
//  Created by Asude Nisa Tıraş on 7.01.2024.
//


import Alamofire
import Foundation

public protocol WeatherServiceProtocol {
    func fetchWeather(city: String, completion: @escaping (Result<[WeatherData], Error>) -> Void)
}
public class WeatherService: WeatherServiceProtocol {
    
    var cachedData: [WeatherData] = []
    
    public init () {
        
    }
   
    public func fetchWeather(city: String, completion: @escaping (Result<[WeatherData], Error>) -> Void) {
        let apiUrl = "https://freetestapi.com/api/v1/weathers"
        
        AF.request(apiUrl)
            .responseDecodable(
                of: [WeatherData].self,
                decoder: WeatherDecoders.weatherDecoder
            ) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let weatherArray):
                    self.cachedData = weatherArray
                  
                    if city.isEmpty {
                        completion(.success(weatherArray))
                    } else {
                        let filteredWeather = weatherArray.filter { $0.city?.lowercased().contains(city.lowercased()) ?? false }
                        completion(.success(filteredWeather))
                    }
                case .failure(let error):
                    switch error {
                    case .createURLRequestFailed(_):
                        completion(.success(self.cachedData))
                    default:
                        completion(.failure(error))
                    }
                }
            }
    }
}
