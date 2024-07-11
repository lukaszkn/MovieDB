//
//  AppCoordinator.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  Main application coordinator for navigation/routing

import UIKit

class AppCoordinator: Coordinator {
    
    /// Empty child coordinators. When application grows in size, this will be used to coordinate child ones
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    /// Initialise app coordinator with main navigation controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Start main app coordinator which shows movie list screen
    func start() {
        /// Instantiate movie list view controller and its view model
        let viewController = MovieListViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = MovieListViewModel()
        
        /// Push movie list view controller with horizontal transition
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Show movie details
    func showMovieDetails(movieModel: MovieModel) {
        let viewController = MovieDetailsViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = MovieDetailsViewModel(movieModel: movieModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
