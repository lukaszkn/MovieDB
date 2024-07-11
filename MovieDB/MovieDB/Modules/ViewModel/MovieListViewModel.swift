//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import Foundation

class MovieListViewModel {
    let title = "Now Playing"
    
    var movies: [Movie] = []
    var movieDBService: MovieDBServiceProtocol
    
    init() {
        movieDBService = AppDelegate.instance.container.resolve(MovieDBServiceProtocol.self)!
    }
    
    func fetchMovies() async {
        do {
            let moviesResponse = try await movieDBService.fetchMovies()
            
            movies = moviesResponse.results
        } catch {
            
        }
    }
}
