//
//  MovieModel.swift
//  MovieDB
//
//  Created by Lukasz on 11/07/2024.
//
//  Movie model which combines Movie and user specific properties

class MovieModel {
    /// Movie structure
    var movie: Movie
    
    /// If movie is user's favourite
    var isFavourite: Bool
    
    /// Initialise object with movie and favourite status
    init(movie: Movie, isFavourite: Bool) {
        self.movie = movie
        self.isFavourite = isFavourite
    }
}
