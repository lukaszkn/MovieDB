//
//  MovieDBServiceTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 10/07/2024.
//

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
    
}
