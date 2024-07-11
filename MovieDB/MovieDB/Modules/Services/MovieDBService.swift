//
//  MovieDBService.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import Foundation

/// Async-await in Swift allows for structured concurrency, improving the readability of complex asynchronous code.
/// Swift Concurrency Manifesto by Chris Lattner https://gist.github.com/lattner/31ed37682ef1576b16bca1432ea9f782
/// With async/await now in Swift itself, the Result type introduced in Swift 5.0 becomes much less important as one of its primary benefits was improving completion handlers.

protocol MovieDBServiceProtocol {
    func fetchMovies() async throws -> MoviesResponse
    
    func searchMovie(query: String) async throws -> MoviesResponse
}

class MovieDBService: MovieDBServiceProtocol {
    
    /// https://developer.themoviedb.org/reference/movie-now-playing-list
    func fetchMovies() async throws -> MoviesResponse {
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        let moviesResponse: MoviesResponse = try await MovieDBService.request(url: TMDBEndpoint.fetchNowPlayingUrl, queryItems: queryItems)
        return moviesResponse
    }
    
    /// https://developer.themoviedb.org/reference/search-movie
    func searchMovie(query: String) async throws -> MoviesResponse {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        let moviesResponse: MoviesResponse = try await MovieDBService.request(url: TMDBEndpoint.searchMovieUrl, queryItems: queryItems)
        return moviesResponse
    }
}

class MovieDBServiceMock: MovieDBServiceProtocol {
    static let movies = [
        Movie(id: 1, title: "Movie title 1", posterPath: "jdfhgkjdfs.jpg", originalTitle: "", releaseDate: "", overview: "", voteAverage: 5.0),
        Movie(id: 2, title: "Movie title 2", posterPath: "gdfgsfggsfd.jpg", originalTitle: "", releaseDate: "", overview: "", voteAverage: 5.0),
        Movie(id: 3, title: "Movie title 3", posterPath: "gdfgseeesfd.jpg", originalTitle: "", releaseDate: "", overview: "", voteAverage: 5.0),
        Movie(id: 4, title: "Movie title 4", posterPath: "gdfgsaaasfd.jpg", originalTitle: "", releaseDate: "", overview: "", voteAverage: 5.0),
        Movie(id: 5, title: "Movie title 5", posterPath: "gdfgsbfdsfd.jpg", originalTitle: "", releaseDate: "", overview: "", voteAverage: 5.0)
    ]
    
    func fetchMovies() async throws -> MoviesResponse {
        return MoviesResponse(results: Self.movies,
                              totalPages: 1,
                              totalResults: Self.movies.count)
    }
    
    func searchMovie(query: String) async throws -> MoviesResponse {
        return MoviesResponse(results: Self.movies.filter({ movie in
                                  movie.title.contains(query) || movie.originalTitle.contains(query)
                              }),
                              totalPages: 1,
                              totalResults: 1)
    }
}

extension MovieDBService {
    private static func request<T: Decodable>(url: String, queryItems: [URLQueryItem] = [], apiKey: String = TMDBEndpoint.apiKey) async throws -> T {
        guard let linkURL = URL(string: url) else {
            throw APIError.invalidUrl
        }
        
        var components = URLComponents(url: linkURL, resolvingAgainstBaseURL: true)!
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidData
        }
        
        guard httpResponse.statusCode <= 299 else {
            throw APIError.invalidData
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch let error {
            print(error.localizedDescription)
            throw APIError.decodingFailed
        }
    }
    
    enum APIError: Error {
        case invalidUrl
        case invalidData
        case decodingFailed
    }
}
