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
    func setResultText(_ newText: String)
  
}


class HomeViewController: UIViewController, UISearchBarDelegate {
    
    private let cityLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
           label.textAlignment = .center
           return label
       }()

       private let temperatureLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
           label.textAlignment = .center
           return label
       }()

       private let countryLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 18)
           label.textAlignment = .center
           return label
       }()

       private let otherInfoLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16)
           label.textAlignment = .left
           label.numberOfLines = 0  // Birden fazla satırı desteklemek için
           return label
       }()
    private func setupLabels() {
           // Şehir label'ı
           view.addSubview(cityLabel)
           cityLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           ])

           // Derece label'ı
           view.addSubview(temperatureLabel)
           temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
               temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           ])

           // Ülke label'ı
           view.addSubview(countryLabel)
           countryLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               countryLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
               countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               countryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           ])

           // Diğer özellikler label'ı
           view.addSubview(otherInfoLabel)
           otherInfoLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               otherInfoLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
               otherInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               otherInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           ])
       }

    let weatherImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    let searchBar = UISearchBar()
    let resultLabel = UILabel()
   
    var presenter: HomePresenterProtocol?
    
    private var weatherService: WeatherServiceProtocol = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupSubviews()
        setupWeatherImageView()
       
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
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchDidTap(searchBar.text)
        let isRainy = true // Replace this with your condition check

                // Update UI based on weather conditions
                updateUIForWeatherCondition(isRainy: isRainy)
    }
    private func updateUIForWeatherCondition(isRainy: Bool) {
        if isRainy {
            // Show rainy image
            weatherImageView.image = UIImage(systemName: "cloud.rain")
        } else {
            // Show sunny image
            weatherImageView.image = UIImage(systemName: "sun.max")
        }

        // Update other UI elements as needed
        // ...

        // Set a larger font size for the cityLabel
        cityLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)

        // Show the result label
        resultLabel.isHidden = false
    }


    private func setupResultLabel() {
        resultLabel.numberOfLines = 0
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Enter city"
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension HomeViewController: HomeViewControllerProtocol {
    func setupSubviews() {
           view.backgroundColor = .white
           setupSearchBar()
           setupResultLabel()
         // Add this method to set up your table view
       }
    
    func setResultText(_ newText: String) {
        self.resultLabel.text = newText
    }




}



