//
//  MovieDetailsViewModelTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 11/07/2024.
//
//  Tests for movie details view model

import XCTest
@testable import MovieDB

final class MovieDetailsViewModelTests: XCTestCase {
    
    /// Test toggling favourite movie state. Use movie list view model for that instead of local storage service directly
    func testToggleMovieFavourite() {
        let service = AppDelegate.instance.container.resolve(LocalStorageServiceProtocol.self)!
        service.clearAll()
        
        let movie = Movie(id: 1, title: "", posterPath: "", originalTitle: "", releaseDate: "", overview: "", voteAverage: 0)
        let movieModel = MovieModel(movie: movie, isFavourite: false)
        
        let viewModel = MovieDetailsViewModel(movieModel: movieModel)
        
        XCTAssertFalse(movieModel.isFavourite, "Fav state should be false")
        
        viewModel.toggleFavouriteStatus()
        
        XCTAssertTrue(movieModel.isFavourite, "Fav state should be true")
        XCTAssertTrue(viewModel.movieModel.isFavourite, "Fav state should be true")
    }
    
}
