//
//  AppCoordinatorTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 12/07/2024.
//
//  Tests for app coordinator/navigation/routing

import XCTest
@testable import MovieDB

final class AppCoordinatorTests: XCTestCase {
    
    /// Check if main navigation starts with Movie list
    func testMovieListNavigationStart() {
        
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        /// Start app coordinator
        appCoordinator.start()
        
        XCTAssertTrue(navigationController.topViewController is MovieListViewController, "Navigation should start with Movie list view controller")
    }
    
    func testMovieListToDetailsNavigation() {
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        
        /// Show movie list
        appCoordinator.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // wait for transition animation finishes
            
            let movie = Movie(id: 1, title: "", posterPath: "", originalTitle: "", releaseDate: "", overview: "", voteAverage: 0)
            let movieModel = MovieModel(movie: movie, isFavourite: false)
            
            /// Navigate to movie details
            appCoordinator.showMovieDetails(movieModel: movieModel)
            
            XCTAssertTrue(navigationController.topViewController is MovieDetailsViewController, "Navigation should go to with Movie details view controller")
        }
    }
}
