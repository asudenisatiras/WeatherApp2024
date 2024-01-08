//
//  WeatherService.swift
//
//
//  Created by Asude Nisa Tıraş on 7.01.2024.
//

//import Alamofire
//import Foundation
//func getWeatherData() {
//    let apiUrl = "https://freetestapi.com/api/v1/weathers"
//
//    AF.request(apiUrl).responseJSON { response in
//        switch response.result {
//        case .success(let data):
//            if let weatherArray = data as? [[String: Any]] {
//                // Veriyi işleme devam et
//                for weatherData in weatherArray {
//                    if let city = weatherData["city"] as? String,
//                       let temperature = weatherData["temperature"] as? Double,
//                       let description = weatherData["weather_description"] as? String {
//                        print("City: \(city), Temperature: \(temperature), Description: \(description)")
//                    }
//                }
//            } else {
//                print("Hatalı veri formatı")
//            }
//        case .failure(let error):
//            print("Hata: \(error)")
//        }
//    }
//}


import Alamofire
import Foundation

public protocol WeatherServiceProtocol {
    func fetchWeather(city: String, completion: @escaping (Result<[WeatherData], Error>) -> Void)
}

public class WeatherService: WeatherServiceProtocol {
    public init () {
        
    }
    public func fetchWeather(city: String, completion: @escaping (Result<[WeatherData], Error>) -> Void) {
        let apiUrl = "https://freetestapi.com/api/v1/weathers"

        AF.request(apiUrl).responseDecodable(of: [WeatherData].self) { response in
            switch response.result {
            case .success(let weatherArray):
                // Filter the weatherArray based on the requested city
                let filteredWeather = weatherArray.filter { $0.city.lowercased() == city.lowercased() }
                completion(.success(filteredWeather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
