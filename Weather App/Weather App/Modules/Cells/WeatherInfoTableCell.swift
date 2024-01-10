//
//  WeatherInfoTableCell.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 8.01.2024.
//

import UIKit

protocol WeatherInfoTableCellProtocol: AnyObject {
    func configure(
        cityText: String?,
        countryText: String?,
        temperatureText: String?,
        weatherInfoText: String?
    )
    func resetSubviews()
    func setButtonImage(systemName: String)
}

final class WeatherInfoTableCell: UITableViewCell {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: WeatherInfoTablePresenterProtocol? {
        didSet {
            presenter?.cellDidDequeue()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        presenter?.cellDidPrepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        configureCellAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellAppearance() {
        
        //        contentView.backgroundColor = UIColor(red: 175/255.0, green: 210/255.0, blue: 229/255.0, alpha: 1.0)
        
    }
    
    private func setupSubviews() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(weatherInfoLabel)
        addSubview(favoriteButton)
        
        // City Label
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
        // Temperature Label
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: -15),
//            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        // Country Label
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 0),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
        // Other Info Label
        weatherInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherInfoLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            weatherInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            weatherInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        // Favorite Button
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc private func favoriteButtonTapped() {
        presenter?.favoriteButtonDidTap()
    }
}

extension WeatherInfoTableCell: WeatherInfoTableCellProtocol {
    
    func configure(cityText: String?, countryText: String?, temperatureText: String?, weatherInfoText: String?) {
        cityLabel.text = cityText
        countryLabel.text = countryText
        temperatureLabel.text = temperatureText
        weatherInfoLabel.text = weatherInfoText
    }
    
    func resetSubviews() {
        cityLabel.text = nil
        temperatureLabel.text = nil
        countryLabel.text = nil
        weatherInfoLabel.text = nil
        favoriteButton.setImage(nil, for: .normal)
    }
    
    func setButtonImage(systemName: String) {
        favoriteButton.setImage(UIImage(systemName: systemName), for: .normal)
    }
}
