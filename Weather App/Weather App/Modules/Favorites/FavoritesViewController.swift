//
//  FavoritesViewController.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import UIKit
import WeatherAPI

protocol FavoritesViewControllerProtocol: AnyObject {
    func setupSubviews()
    func reloadData()
    func showEmptyView()
    func hideEmptyView()
}

class FavoritesViewController: UITableViewController, FavoritesViewControllerProtocol {
    
    var presenter: FavoritesPresenterProtocol?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
  
    private func setupTableView() {
        tableView.register(WeatherInfoTableCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.separatorColor = .systemBlue
        tableView.separatorStyle = .singleLine
    }
    
    func setupSubviews() {
        setupTableView()
        self.title = "Favorites"
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }
    func showEmptyView() {
        let noFavoritesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noFavoritesLabel.text = "There is no favorites here"
        noFavoritesLabel.textAlignment = .center
        noFavoritesLabel.font = .systemFont(ofSize: 22)
        tableView.backgroundView = noFavoritesLabel
        tableView.separatorStyle = .none
    }
    
    func hideEmptyView() {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataCount ?? .zero
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! WeatherInfoTableCell
        WeatherInfoTableCellBuilder.createModule(cell: cell, data: presenter?.weatherData(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCell(at: indexPath.row)
        
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            presenter?.didRemoveCell(at: indexPath.row)
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
