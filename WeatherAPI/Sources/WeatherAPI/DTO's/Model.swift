//
//  Model.swift
//
//
//  Created by Asude Nisa Tıraş on 7.01.2024.
//

import Foundation

public struct WeatherData: Codable {
    public let id: Int?
    public let city: String?
    public let country: String?
    public let latitude: Double?
    public let longitude: Double?
    public let temperature: Double
    public let weatherDescription: String?
    public let humidity: Int?
    public let windSpeed: Double?
    public let forecast: [ForecastData]?
    
    private enum CodingKeys: String, CodingKey {
        case id, city, country, latitude, longitude, temperature, humidity, forecast
        case weatherDescription = "weather_description"
        case windSpeed = "wind_speed"
    }
}

public struct ForecastData: Codable {
    public let date: Date?
    public let temperature: Double?
    public let weatherDescription: String?
    public let humidity: Int?
    public let windSpeed: Double?

    private enum CodingKeys: String, CodingKey {
        case date, temperature, humidity
        case weatherDescription = "weather_description"
        case windSpeed = "wind_speed"
    }
    
}



