//
//  MovieListViewModelTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 11/07/2024.
//
//  Tests for movie list view model

import XCTest
@testable import MovieDB

final class MovieListViewModelTests: XCTestCase {
    
    /// Test fetching movies
    func testFetchMovies() async throws {
        /// Use mock API service instead of live one
        await AppDelegate.instance.container.register(MovieDBServiceProtocol.self) { _ in MovieDBServiceMock() }.inObjectScope(.container)
        
        let viewModel = MovieListViewModel()
        
        await viewModel.fetchMovies()
        
        XCTAssert(viewModel.movies.count == 5)
    }
    
    /// Test searching movies
    func testSearchMovies() async throws {
        /// Use mock API service instead of live one
        await AppDelegate.instance.container.register(MovieDBServiceProtocol.self) { _ in MovieDBServiceMock() }.inObjectScope(.container)
        
        let viewModel = MovieListViewModel()
        
        await viewModel.searchMovies(query: "hunt")
        
        XCTAssert(viewModel.movies.count == 1, "There should be 1 title")
        XCTAssert(viewModel.movies[0].movie.title == "The hunt for", "Titles should match")
    }
    
    /// Test toggling favourite movie state. Use movie list view model for that instead of local storage service directly
    func testToggleMovieFavourite() {
        let viewModel = MovieListViewModel()
        
        let service = AppDelegate.instance.container.resolve(LocalStorageServiceProtocol.self)!
        service.clearAll()
        
        let movie = Movie(id: 1, title: "", posterPath: "", originalTitle: "", releaseDate: "", overview: "", voteAverage: 0)
        let movieModel = MovieModel(movie: movie, isFavourite: false)
        
        viewModel.toggleFavouriteStatus(movieModel: movieModel)
        
        XCTAssertTrue(movieModel.isFavourite, "Fav state should be true")
        XCTAssertTrue(viewModel.isMovieFavourite(movie: movie), "Fav state should be true")
    }
}
