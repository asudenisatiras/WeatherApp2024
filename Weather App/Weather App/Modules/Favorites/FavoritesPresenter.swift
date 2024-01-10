//
//  FavoritesPresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation
import WeatherAPI
import UIKit
protocol FavoritesPresenterProtocol : AnyObject {
    var dataCount: Int { get }
    func didSelectCell(at index : Int)
    func weatherData(at index: Int) -> WeatherData?
    func viewDidLoad()
    func viewWillAppear()
    func didRemoveCell(at index : Int)
}

final class FavoritesPresenter {
    var weatherData: [WeatherData] = []
    
    unowned let view: FavoritesViewControllerProtocol
    let router: FavoritesRouterProtocol
    let interactor: FavoritesInteractorProtocol
    init(view: FavoritesViewControllerProtocol, router: FavoritesRouterProtocol, interactor: FavoritesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    private func setEmptyView() {
        if weatherData.isEmpty {
            view.showEmptyView()
        } else {
            view.hideEmptyView()
        }
    }
}
extension FavoritesPresenter : FavoritesPresenterProtocol {
    func didRemoveCell(at index: Int) {
        weatherData = interactor.removeFromFavorites(data: weatherData[index])
        setEmptyView()
        view.reloadData()
    }
    
    func viewDidLoad() {
        view.setupSubviews()
    }
    
    func viewWillAppear() {
        weatherData = interactor.getFavorites()
        setEmptyView()
        view.reloadData()
    }
    
    var dataCount: Int {
        weatherData.count
    }
    func weatherData(at index: Int) -> WeatherAPI.WeatherData? {
        guard index >= 0, index < weatherData.count else {
            return nil
        }
        return weatherData[index]
    }
    
    func didSelectCell(at index: Int) {
        let selectedWeatherData = weatherData(at: index)
        router.navigateToDetail(selectedWeatherData)
        
    }
}
