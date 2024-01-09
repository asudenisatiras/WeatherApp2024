//
//  FavoritesViewController.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import UIKit
import WeatherAPI

protocol FavoritesViewControllerProtocol: AnyObject {
    func loadFavoriteWeatherData()
}

class FavoritesViewController: UITableViewController, FavoritesViewControllerProtocol {

    var presenter: FavoritesPresenterProtocol?
    var favoriteWeatherData: [WeatherData] = []
    let userDefaultsService: UserDefaultsServiceProtocol = UserDefaultsService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadFavoriteWeatherData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteWeatherData()
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.register(WeatherInfoTableCell.self, forCellReuseIdentifier: "FavoriteCell")
    }

    public func loadFavoriteWeatherData() {
        favoriteWeatherData = userDefaultsService.getFavorites()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteWeatherData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! WeatherInfoTableCell
        let weatherData = favoriteWeatherData[indexPath.row]
        cell.configure(
            cityText: weatherData.city,
            countryText: weatherData.country,
            temperatureText: "\(weatherData.temperature)°C",
            weatherInfoText: weatherData.weatherDescription
        )
        cell.setButtonImage(systemName: "star.fill")
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection if needed
    }

    // MARK: - Swipe actions for delete

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let deletedWeather = self.favoriteWeatherData.remove(at: indexPath.row)
            self.userDefaultsService.removeFromFavorite(weather: deletedWeather)
            self.tableView.reloadData()

            // Bildirimi post et
            NotificationCenter.default.post(name: .didUpdateFavorites, object: nil)

            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
