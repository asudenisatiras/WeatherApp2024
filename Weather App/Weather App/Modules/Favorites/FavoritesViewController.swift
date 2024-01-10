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
        self.title = "Favorites"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteWeatherData()
        tableView.reloadData()
    }
  
    private func setupTableView() {
        tableView.register(WeatherInfoTableCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.separatorColor = .systemBlue
        tableView.separatorStyle = .singleLine
    }

    public func loadFavoriteWeatherData() {
        let favorites = userDefaultsService.getFavorites()
        presenter?.setWeatherData(favorites)
        favoriteWeatherData = favorites
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfFavorites = favoriteWeatherData.count

        if numberOfFavorites == 0 {
            let noFavoritesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noFavoritesLabel.text = "There is no favorites here"
            noFavoritesLabel.textAlignment = .center
            noFavoritesLabel.font = .systemFont(ofSize: 22)
            tableView.backgroundView = noFavoritesLabel
            tableView.separatorStyle = .none
        } else {
            
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }

        return numberOfFavorites
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! WeatherInfoTableCell
        let weatherData = favoriteWeatherData[indexPath.row]
        cell.configure(
            cityText: weatherData.city,
            countryText: weatherData.country,
            temperatureText: "\(weatherData.temperature)",
            weatherInfoText: weatherData.weatherDescription,
            humidityText: weatherData.humidity,
            windSpeedText: weatherData.windSpeed
            
        )
        cell.setButtonImage(systemName: "star.fill")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectCell called at indexPath: \(indexPath)")
        if let selectedWeatherData = presenter?.weatherData(at: indexPath.row) {
            presenter?.didSelectCell(at: indexPath.row)
        } else {
            print("Error: Selected Weather Data is nil.")
        }
    }

        


    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let deletedWeather = self.favoriteWeatherData.remove(at: indexPath.row)
            self.userDefaultsService.removeFromFavorite(weather: deletedWeather)
            self.tableView.reloadData()

            NotificationCenter.default.post(name: .didUpdateFavorites, object: nil)

            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
