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
   func searchDidChange(_ searchText: String?)
   func didSelectItem(at index: Int)
   func numberOfRows() -> Int
   func weatherData(at index: Int) -> WeatherData?
   var dataCount: Int { get }
   func didSelectCell(at index : Int)
}

final class HomePresenter {
   unowned let view: HomeViewControllerProtocol
   let router: HomeRouterProtocol
   let interactor: HomeInteractorProtocol
   
   var weatherData: [WeatherData] = []
   
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
   
   var dataCount: Int {
      weatherData.count
   }
   
   func didSelectCell(at index : Int) {
      let selectedWeatherData = weatherData(at: index)
      router.navigateToDetail(selectedWeatherData)
      
   }
   
   
   func numberOfRows() -> Int {
      return weatherData.count
   }
   
   func weatherData(at index: Int) -> WeatherData? {
      guard index >= 0, index < weatherData.count else {
         return nil
      }
      return weatherData[index]
   }
   
   func viewDidLoad() {
      view.setupSubviews()
      interactor.downloadWeatherData(nil)
   }

   func searchDidChange(_ searchText: String?) {
      interactor.downloadWeatherData(searchText)
   }
   
   func didSelectItem(at index: Int) {
      router.navigateToDetail(weatherData[index])
   }
}

extension HomePresenter: HomeInteractorOutputProtocol {
   func weatherDataResult(_ data: [WeatherData]) {
      self.weatherData = data
      if UserDefaultsService().isFavorite(weather: weatherData.first) {
         print("service approved")
      }
      // Reload the table view to reflect the changes
      view.reloadData()
   }
   
   func weatherDataFetchError(_ errorMessage: String) {
      print("Error fetching weather data: \(errorMessage)")
      // You can handle the error message if needed
   }
}
