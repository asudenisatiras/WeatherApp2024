//
//  DetailsPresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

//import Foundation
//import WeatherAPI
//
//protocol DetailsPresenterProtocol: AnyObject {
//    func viewDidLoad()
//}
//
//final class DetailsPresenter {
//    
//    unowned let view: DetailsViewControllerProtocol
//    let router: DetailsRouterProtocol
//    let interactor: DetailsInteractorProtocol
//    
//    let weatherData : WeatherData?
//    init(view: DetailsViewControllerProtocol, router: DetailsRouterProtocol, interactor: DetailsInteractorProtocol, weatherData: WeatherData?) {
//        self.view = view
//        self.router = router
//        self.interactor = interactor
//        self.weatherData = weatherData
//    }
//    
//}
//
//extension DetailsPresenter : DetailsPresenterProtocol {
//    func viewDidLoad() {
//        view.setupSubviews()
//        
//    }
//    
//    
//}
import Foundation
import WeatherAPI

protocol DetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class DetailsPresenter {
    
    unowned let view: DetailsViewControllerProtocol
    let router: DetailsRouterProtocol
    let interactor: DetailsInteractorProtocol
    
    let weatherData: WeatherData?
    
    init(view: DetailsViewControllerProtocol, router: DetailsRouterProtocol, interactor: DetailsInteractorProtocol, weatherData: WeatherData?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.weatherData = weatherData
    }
    
    private func makeForecastLabel() -> [String] {
        let array = [String]()
        if let forecast = weatherData?.forecast {
            return forecast.map({
                """
                Date: \($0.date ?? "")
                Temperature: \($0.temperature ?? 0.0)
                Type: \($0.weatherDescription ?? "")
                Humidity: \($0.humidity ?? 0)%
                Wind Speed: \($0.windSpeed ?? 0.0)
                """
            })
        } else {
            return []
        }
    }
}
extension DetailsPresenter: DetailsPresenterProtocol {
    func viewDidLoad() {
        view.setupSubviews()
        view.configure(city: weatherData?.city, temperature: weatherData?.temperature, description: weatherData?.weatherDescription, humidity: weatherData?.humidity, country: weatherData?.country, windSpeed: weatherData?.windSpeed)
        view.createForecastlabels(strings: makeForecastLabel())
    }
}
