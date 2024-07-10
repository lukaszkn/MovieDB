//
//  MoviesResponse.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

struct MoviesResponse: Codable {
    let results: [Movie]
    
    let totalPages: Int
    let totalResults: Int
}
