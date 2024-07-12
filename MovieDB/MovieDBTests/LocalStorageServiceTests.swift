//
//  LocalStorageServiceTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 11/07/2024.
//
//  Tests for local storage service

import XCTest
@testable import MovieDB

final class LocalStorageServiceTests: XCTestCase {
    
    /// Test is favourite
    func testIsFavourite() {
        let service = LocalStorageService()
        service.clearAll()
        
        let movie = Movie(id: 1, title: "", posterPath: "", originalTitle: "", releaseDate: "", overview: "", voteAverage: 0)
        
        XCTAssertFalse(service.isMovieFavourite(movie: movie), "Fav state should be false")
    }
    
    /// Test togging favourite state
    func testToggleFavourite() {
        let service = LocalStorageService()
        service.clearAll()
        
        let movie = Movie(id: 1, title: "", posterPath: "", originalTitle: "", releaseDate: "", overview: "", voteAverage: 0)
        
        let movieModel = MovieModel(movie: movie, isFavourite: false)
        service.toggleFavouriteMovieStatus(movieModel: movieModel)
        
        XCTAssertTrue(service.isMovieFavourite(movie: movie), "Fav state should be true")
    }
    
}
