//
//  TMDBEndpoint.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import Foundation

struct TMDBEndpoint {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let posterUrl = "https://image.tmdb.org/t/p/w500"
    
    static func posterImageUrl(path: String) -> URL? {
        URL(string: posterUrl + path)
    }
    
    static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTgwZjJiOTRhMWY4MWM4MTU1MTRjYzE3OGVmNjgzZiIsIm5iZiI6MTcxOTM4NDY1MS45MzY0NDcsInN1YiI6IjY2N2JiOGMyMzk0MDVjMzgyZmFhNmFkZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nRYPK4dCNymbFA34-IQIClJyG-Mf31n6YmPmZyoUIqc"
    
    static var fetchNowPlayingUrl: String {
        baseUrl + "/movie/now_playing"
    }
}
