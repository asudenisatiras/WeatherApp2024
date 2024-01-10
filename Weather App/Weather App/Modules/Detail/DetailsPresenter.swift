//
//  DetailsPresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//
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
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func viewDidLoad() {
        view.setupSubviews(with: weatherData)
        print("Forecast Data: \(weatherData?.forecast ?? [])")

    }
}
