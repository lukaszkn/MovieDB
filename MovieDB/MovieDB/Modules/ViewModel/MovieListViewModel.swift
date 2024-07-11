//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  View model for movie list screen

import Foundation

class MovieListViewModel {
    /// Title for movie list screen
    let title = "Now Playing"
    
    /// Populated movie list
    var movies: [MovieModel] = []
    
    /// Reference to movie database service
    private var movieDBService: MovieDBServiceProtocol
    /// Reference to local storage service
    private var localStorageService: LocalStorageServiceProtocol
    
    /// Initialise view model and resolve required dependencies
    init() {
        movieDBService = AppDelegate.instance.container.resolve(MovieDBServiceProtocol.self)!
        localStorageService = AppDelegate.instance.container.resolve(LocalStorageServiceProtocol.self)!
    }
    
    func fetchMovies() async {
        do {
            let moviesResponse = try await movieDBService.fetchMovies()
            
            movies = moviesResponse.results.map({ movie in
                MovieModel(movie: movie, isFavourite: localStorageService.isMovieFavourite(movie: movie))
            })
        } catch {
            
        }
    }
    
    func searchMovies(query: String) async {
        let moviesResponse = try? await movieDBService.searchMovie(query: query)
            
        if let moviesResponse {
            movies = moviesResponse.results.map({ movie in
                MovieModel(movie: movie, isFavourite: localStorageService.isMovieFavourite(movie: movie))
            })
        }
    }
    
    func isMovieFavourite(movie: Movie) -> Bool {
        localStorageService.isMovieFavourite(movie: movie)
    }
    
    func toggleFavouriteStatus(movieModel: MovieModel) {
        localStorageService.toggleFavouriteMovieStatus(movieModel: movieModel)
    }
}
