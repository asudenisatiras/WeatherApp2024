//
//  HomePresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import Foundation
import WeatherAPI

// Define the protocol for HomePresenter
protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func searchDidTap(_ searchText: String?)
    func didSelectItem(at index: Int)
    func numberOfRows() -> Int
    func weatherData(at index: Int) -> WeatherData?
    func loadInitialData()
    var weatherData: [WeatherData] { get set }
  
}

final class HomePresenter {
    unowned let view: HomeViewControllerProtocol
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol

    var weatherData: [WeatherAPI.WeatherData] = []

    init(
        view: HomeViewControllerProtocol,
        router: HomeRouterProtocol,
        interactor: HomeInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
   
    
    func numberOfRows() -> Int {
        return weatherData.count
    }

    func weatherData(at index: Int) -> WeatherAPI.WeatherData? {
        guard index >= 0, index < weatherData.count else {
            return nil
        }
        return weatherData[index]
    }

    func viewDidLoad() {
        view.setupSubviews()
        loadInitialData()
    }

    func searchDidTap(_ searchText: String?) {
        guard let searchText, !searchText.isEmpty else {
            view.setResultText("Please enter a city name.")
            return
        }

        interactor.downloadWeatherData(searchText)
    }

    func didSelectItem(at index: Int) {
        router.navigateToDetail(weatherData[index])
    }

    func loadInitialData() {
        // Implement logic to load initial data and update the view
        interactor.downloadWeatherData(nil)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func weatherDataResult(_ data: [WeatherAPI.WeatherData]) {
        self.weatherData = data

        if data.isEmpty {
            view.setResultText("Network Error Occupied")
        } else {
            let resultText = data.map {
                """
                City: \(String(describing: $0.city))
                Country: \(String(describing: $0.country))
                Temperature: \(String(describing: $0.temperature))°C
                Description: \(String(describing: $0.weatherDescription))
                Humidity: \(String(describing: $0.humidity))%
                Wind Speed: \($0.windSpeed ?? 0 )
                """
            }.joined(separator: "\n\n")

            view.setResultText(resultText)
        }
    }

    func weatherDataFetchError(_ errorMessage: String) {
        print("Error fetching weather data: \(errorMessage)")
        // Handle the error message
        view.setResultText(errorMessage)
        // You can also update your UI or show an alert to the user
    }
}
