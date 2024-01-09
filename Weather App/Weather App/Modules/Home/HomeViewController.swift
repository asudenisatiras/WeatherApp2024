//
//  HomeViewController.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 7.01.2024.
//

import UIKit
import WeatherAPI
import Alamofire

protocol HomeViewControllerProtocol: AnyObject {
    func setupSubviews()
    func reloadData()
}

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let searchBar = UISearchBar()
    let resultLabel = UILabel()
    
    var presenter: HomePresenterProtocol?
    var favorite: FavoritesViewControllerProtocol?
    private var weatherService: WeatherServiceProtocol = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           NotificationCenter.default.addObserver(self, selector: #selector(didUpdateFavorites), name: .didUpdateFavorites, object: nil)
       }
    @objc func didUpdateFavorites() {
        favorite?.loadFavoriteWeatherData()
            tableView.reloadData()
        }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherInfoTableCell.self, forCellReuseIdentifier: "weatherInfoCell")
    }
    
    private func setupWeatherImageView() {
        view.addSubview(weatherImageView)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: searchBar.topAnchor)
        ])
    }
    
    private func updateUIForWeatherCondition(isRainy: Bool) {
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchDidChange(searchText)
    }
    private func setupSearchBar() {
        searchBar.placeholder = "Enter city"
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
      
        let weatherLabel = UILabel()
        weatherLabel.text = "Weather Conditions"
        weatherLabel.textAlignment = .left
        weatherLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        weatherLabel.textColor = .black
        view.addSubview(weatherLabel)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherLabel.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension HomeViewController: HomeViewControllerProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func setupSubviews() {
        view.backgroundColor = UIColor(red: 175/255.0, green: 210/255.0, blue: 229/255.0, alpha: 1.0)
        setupSearchBar()
        setupWeatherImageView()
        setupTableView()
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherInfoCell", for: indexPath) as! WeatherInfoTableCell
        
        let weatherData = presenter?.weatherData(at: indexPath.row)
        WeatherInfoTableCellBuilder.createModule(cell: cell, data: weatherData)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectCell called at indexPath: \(indexPath)")
        presenter?.didSelectCell(at: indexPath.row)
    }
    
}
