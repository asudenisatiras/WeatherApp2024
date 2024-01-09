//
//  FavoritesPresenter.swift
//  Weather App
//
//  Created by Asude Nisa Tıraş on 9.01.2024.
//

import Foundation

protocol FavoritesPresenterProtocol : AnyObject {
    
}

final class FavoritesPresenter {
    
    unowned let view: FavoritesViewControllerProtocol
    let router: FavoritesRouterProtocol
    let interactor: FavoritesInteractorProtocol
    init(view: FavoritesViewControllerProtocol, router: FavoritesRouterProtocol, interactor: FavoritesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}
extension FavoritesPresenter : FavoritesPresenterProtocol {
    
}
