//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Lukasz on 11/07/2024.
//
//  View model for movie details screen

import Foundation

class MovieDetailsViewModel {
    /// Selected movie with details
    let movieModel: MovieModel
    
    /// Reference to user's local storage service
    var localStorageService: LocalStorageServiceProtocol
    
    /// Initialise view model with passed movie model and resolve required dependencies
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
        localStorageService = AppDelegate.instance.container.resolve(LocalStorageServiceProtocol.self)!
    }
    
    /// Toggle movie favourite status using local user storage
    func toggleFavouriteStatus() {
        localStorageService.toggleFavouriteMovieStatus(movieModel: movieModel)
    }
}
