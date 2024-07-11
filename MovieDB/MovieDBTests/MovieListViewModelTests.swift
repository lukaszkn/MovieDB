//
//  MovieListViewModelTests.swift
//  MovieDBTests
//
//  Created by Lukasz on 11/07/2024.
//

import XCTest
@testable import MovieDB

final class MovieListViewModelTests: XCTestCase {
    
    func test1() async throws {
        await AppDelegate.instance.container.register(MovieDBServiceProtocol.self) { _ in MovieDBServiceMock() }.inObjectScope(.container)
        
        let viewModel = MovieListViewModel()
        
        await viewModel.fetchMovies()
        
        XCTAssert(viewModel.movies.count == 3)
    }
}
