//
//  TMDBEndpoint.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//
//  themoviedb.org live API definitions

import Foundation

struct TMDBEndpoint {
    /// Base api service url
    static let baseUrl = "https://api.themoviedb.org/3"
    /// Base url for movie posters. Use width 500px images
    static let posterUrl = "https://image.tmdb.org/t/p/w500"
    
    /// Movie poster url. See: https://developer.themoviedb.org/docs/image-basics
    static func posterImageUrl(path: String) -> URL? {
        URL(string: posterUrl + path)
    }
    
    /// Api key
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTgwZjJiOTRhMWY4MWM4MTU1MTRjYzE3OGVmNjgzZiIsIm5iZiI6MTcxOTM4NDY1MS45MzY0NDcsInN1YiI6IjY2N2JiOGMyMzk0MDVjMzgyZmFhNmFkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nRYPK4dCNymbFA34-IQIClJyG-Mf31n6YmPmZyoUIqc"
    
    /// Now playing movies url
    static var fetchNowPlayingUrl: String {
        baseUrl + "/movie/now_playing"
    }
    
    /// Search movie url
    static var searchMovieUrl: String {
        baseUrl + "/search/movie"
    }
}
