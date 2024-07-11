//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieListViewController.instantiate()
        viewController.coordinator = self
        let viewModel = MovieListViewModel()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showMovieDetails(movie: Movie) {
        
    }
}
