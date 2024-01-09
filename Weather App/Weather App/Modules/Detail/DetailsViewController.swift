//
//  DetailsViewController.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

//import UIKit
//
//
//protocol DetailsViewControllerProtocol: AnyObject {
//    func setupSubviews()
//    
//}
//
//class DetailsViewController: UIViewController {
//    
//    var presenter: DetailsPresenterProtocol?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter?.viewDidLoad()
//        
//    }
//    
//    
//}
//extension DetailsViewController:  DetailsViewControllerProtocol {
//    
//    func setupSubviews() {
//        view.backgroundColor = .red
//        
//    }
//    
//    
//    
//    
//}
import UIKit
import WeatherAPI

protocol DetailsViewControllerProtocol: AnyObject {
    func setupSubviews(with weatherData: WeatherData?)
}

class DetailsViewController: UIViewController {

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .right
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let forecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let humidityIconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(systemName: "humidity") // Replace "humidityIcon" with your actual image asset name
            return imageView
        }()
    private let windSpeedIconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(systemName: "wind") // Replace "humidityIcon" with your actual image asset name
            return imageView
        }()
    var presenter: DetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSubviews()

        presenter?.viewDidLoad()
    }

    private func setupSubviews() {
        view.addSubview(temperatureLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(humidityLabel)
        view.addSubview(cityLabel)
        view.addSubview(countryLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(forecastLabel)
        view.addSubview(humidityIconImageView)
        view.addSubview(windSpeedIconImageView)
        // Add constraints for labels
        NSLayoutConstraint.activate([
            
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            
            temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            humidityIconImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                        humidityIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        humidityIconImageView.widthAnchor.constraint(equalToConstant: 20),
                        humidityIconImageView.heightAnchor.constraint(equalToConstant: 20),

                        humidityLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
                        humidityLabel.leadingAnchor.constraint(equalTo: humidityIconImageView.trailingAnchor, constant: 8),
                        humidityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            windSpeedIconImageView.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            windSpeedIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            windSpeedIconImageView.widthAnchor.constraint(equalToConstant: 20),
            windSpeedIconImageView.heightAnchor.constraint(equalToConstant: 20),
            windSpeedLabel.leadingAnchor.constraint(equalTo: windSpeedIconImageView.trailingAnchor, constant: 8),
            windSpeedLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            windSpeedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            forecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forecastLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 20),
        ])
    }
}

extension DetailsViewController: DetailsViewControllerProtocol {
    func setupSubviews(with weatherData: WeatherData?) {
        if let weatherData = weatherData {
            temperatureLabel.text = "\(weatherData.temperature)°C"
            descriptionLabel.text = "\(weatherData.weatherDescription ?? "")"
            humidityLabel.text = "\(weatherData.humidity ?? 0)%"
            cityLabel.text = "\(weatherData.city ?? "")"
            countryLabel.text = "\(weatherData.country ?? "")"
            windSpeedLabel.text = "\(weatherData.windSpeed ?? 0.0) m/s"
            forecastLabel.text = ""

            if let forecast = weatherData.forecast {
                for data in forecast {
                    if let date = data.date,
                       let temperature = data.temperature,
                       let weatherDescription = data.weatherDescription,
                       let humidity = data.humidity,
                       let windSpeed = data.windSpeed {
                        let forecastText = "\(date) - Temperature: \(temperature) - Weather Description: \(weatherDescription) - Humidity: \(humidity) - Wind Speed: \(windSpeed)"
                        forecastLabel.text?.append("\(forecastText)\n")
                    }
                }
            }
        }
    }
}
