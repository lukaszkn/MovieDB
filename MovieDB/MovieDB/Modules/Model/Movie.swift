//
//  Movie.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  Movie model structure

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    let originalTitle: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
}

extension Movie {
    var details: [String: String] {
        [
            "Original title": originalTitle,
            "Release date": releaseDate,
            "Score": String(describing: voteAverage),
        ]
    }
}
