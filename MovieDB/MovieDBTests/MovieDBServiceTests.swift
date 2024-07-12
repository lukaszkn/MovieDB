//
//  MovieDBServiceTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 10/07/2024.
//
//  Tests for movie database service

import XCTest
@testable import MovieDB

final class MovieDBServiceTests: XCTestCase {
    
    /// Test fetching movies from live api
    /// This is for demo purposes only. Normally the app would not be testing live api
    func testLiveFetchMovies() async throws {
        let service = MovieDBService()
        
        do {
            let moviesResponse = try await service.fetchMovies()
            
            XCTAssert(!moviesResponse.results.isEmpty)
        } catch {
            XCTFail("Fetching movies from live server failed")
        }
    }
    
    /// Test movie searching using mock service data
    func testMockSearchMovies() async throws {
        let service = MovieDBServiceMock()
        
        do {
            let moviesResponse = try await service.searchMovie(query: "hunt")
            
            XCTAssert(moviesResponse.results.count == 1, "We should get 1 title")
            
            XCTAssert(moviesResponse.results[0].id == 5, "Id for the title should be 5")
        } catch {
            XCTFail("Fetching movies from mock")
        }
    }
    
}
