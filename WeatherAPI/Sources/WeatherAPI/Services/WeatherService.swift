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
        retrieveCachedData()
    }
    
    private func saveCachedData() {
        // Save into userDefaults or coreData
    }
    
    private func retrieveCachedData() {
        // Fetch from userDefaults or from coreData
        // cachedData = ...
    }
    
    public func fetchWeather(city: String, completion: @escaping (Result<[WeatherData], Error>) -> Void) {
        let apiUrl = "https://freetestapi.com/api/v1/weathers"
        
        AF.request(apiUrl)
            .responseDecodable(
                of: [WeatherData].self,
                decoder: Decoders.dateDecoder
            ) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let weatherArray):
                    // Update the cached data
                    self.cachedData = weatherArray
                    self.saveCachedData()
                    
                    if city.isEmpty {
                        // If no specific city is provided, return all data
                        completion(.success(weatherArray))
                    } else {
                        // Filter the weatherArray based on the requested city
                        let filteredWeather = weatherArray.filter { $0.city?.lowercased().contains(city.lowercased()) ?? false }
                        completion(.success(filteredWeather))
                    }
                case .failure(let error):
                    // Handle the error appropriately
                    switch error {
                    case .createURLRequestFailed(_):
                        // If URLRequest creation fails, return cached data
                        completion(.success(self.cachedData))
                    default:
                        // Return the error
                        completion(.failure(error))
                    }
                }
            }
    }
}
