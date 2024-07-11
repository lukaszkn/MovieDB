//
//  MoviesResponse.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  Movie response populated from API service

/// Contains movie list and paging details
struct MoviesResponse: Codable {
    let results: [Movie]
    
    /// Total number of pages available
    let totalPages: Int
    
    /// Total number of movies available
    let totalResults: Int
}
