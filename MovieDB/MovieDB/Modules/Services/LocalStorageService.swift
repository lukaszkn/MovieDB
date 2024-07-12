//
//  LocalStorageService.swift
//  MovieDB
//
//  Created by Lukasz on 11/07/2024.
//
//  Local user's storage for keeping data between app's sessions.
//  It uses user defaults to hold information of favourite movies.

import Foundation

protocol LocalStorageServiceProtocol {
    /// Returns true if movie is user's favourite one
    func isMovieFavourite(movie: Movie) -> Bool
    
    /// Toggle favourite status of the movie
    func toggleFavouriteMovieStatus(movieModel: MovieModel)
    
    /// Clear all favourite movies
    func clearAll()
}

/// Implementation of local storage service
class LocalStorageService: LocalStorageServiceProtocol {
    private var movieIds: Set<Int> = Set()
    
    /// Constants used by this service
    enum Settings { static let movieIdsKey = "movieIdsKey" }
    
    init() {
        /// Read existing favourite movies ids
        if let ids = UserDefaults.standard.array(forKey: Settings.movieIdsKey) as? [Int] {
            movieIds = Set(ids)
        }
    }
    
    /// Returns true if movie is user's favourite one
    func isMovieFavourite(movie: Movie) -> Bool {
        movieIds.contains(movie.id)
    }
    
    /// Toggle favourite status of the movie
    func toggleFavouriteMovieStatus(movieModel: MovieModel) {
        if isMovieFavourite(movie: movieModel.movie) {
            /// Remove movie id from favourite array
            movieIds.remove(movieModel.movie.id)
            
            /// Set favourite flag to false
            movieModel.isFavourite = false
        } else {
            /// Insert movie id to favourite array
            movieIds.insert(movieModel.movie.id)
            
            /// Set favourite flag to true
            movieModel.isFavourite = true
        }
        
        save()
    }
    
    /// Clear all stores favourite movies
    func clearAll() {
        movieIds.removeAll()
        save()
    }
    
    /// Save data to user's defaults
    private func save() {
        UserDefaults.standard.setValue(Array(movieIds), forKey: Settings.movieIdsKey)
        UserDefaults.standard.synchronize()
    }
}
