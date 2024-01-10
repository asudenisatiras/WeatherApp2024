//
//  DetailsViewController.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import UIKit
import WeatherAPI

protocol DetailsViewControllerProtocol: AnyObject {
    func setupSubviews()
    func configure(city: String?,
                   temperature:Double?,
                   description: String?,
                   humidity: Int?,
                   country: String?,
                   windSpeed: Double?)
    func createForecastlabels(strings: [String])
}

class DetailsViewController: UIViewController {
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let humidityIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "humidity")
        
        return imageView
    }()
    
    private let windSpeedIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "wind")
        return imageView
    }()
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
    }
    private static func makeLabel (text: String?,textAlignment: NSTextAlignment = .natural ,font: UIFont = .systemFont(ofSize: 17)) -> UILabel {
        let forecastLabel = UILabel()
        forecastLabel.text = text
        forecastLabel.textAlignment = textAlignment
        forecastLabel.numberOfLines = 0
        forecastLabel.font = font
        return forecastLabel
        
    }
    
    private func setupVerticalStackView() {
        
        verticalStackView.addArrangedSubview(Self.makeLabel(text: "Forecasts For Next Two Days", textAlignment: .center,font: .boldSystemFont(ofSize: 20)))
        
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 40),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
    }
    
    
    private func setupHorizontalScrollStackView(){
        
        let scrollView = UIScrollView()
        scrollView.addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -8),
            horizontalStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 8)
            
        ])
        
        verticalStackView.addArrangedSubview(scrollView)
        
        
    }
    private func setupAlignment() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor(red: 175/255.0, green: 210/255.0, blue: 229/255.0, alpha: 1.0)
        backgroundView.layer.cornerRadius = 12
        
        
        view.insertSubview(backgroundView, at: 0)
        
        
        view.addSubview(temperatureLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(humidityLabel)
        view.addSubview(cityLabel)
        view.addSubview(countryLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(humidityIconImageView)
        view.addSubview(windSpeedIconImageView)
        
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            
            temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
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
        ])
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -10),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            backgroundView.bottomAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 10),
        ])
    }
}

extension DetailsViewController: DetailsViewControllerProtocol {
    func createForecastlabels(strings: [String]) {
        
        for string in strings {
            let label = Self.makeLabel(text: string)
            horizontalStackView.addArrangedSubview(label)
        }
        view.setNeedsLayout()
    }
    
    func configure(city: String?, temperature: Double?, description: String?, humidity: Int?, country: String?, windSpeed: Double?) {
        temperatureLabel.text = "\(temperature ?? .zero)°C"
        descriptionLabel.text = "\(description ?? "")"
        humidityLabel.text = "\(humidity ?? 0)%"
        cityLabel.text = "\(city ?? "")"
        countryLabel.text = "\(country ?? "")"
        windSpeedLabel.text = "\(windSpeed ?? 0.0) m/s"
        
    }
    
    func setupSubviews() {
        self.title = "Details"
        view.backgroundColor = .white
        setupAlignment()
        setupVerticalStackView()
        setupHorizontalScrollStackView()
    }
    
}
