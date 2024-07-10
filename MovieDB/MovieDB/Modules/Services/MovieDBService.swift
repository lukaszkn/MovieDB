//
//  MovieDBService.swift
//  MovieDB
//
//  Created by Lukasz on 10/07/2024.
//

import Foundation

protocol MovieDBServiceProtocol {
    func fetchMovies() async throws -> MoviesResponse
}

class MovieDBService: MovieDBServiceProtocol {
    func fetchMovies() async throws -> MoviesResponse {
        let moviesResponse: MoviesResponse = try await MovieDBService.request(url: TMDBEndpoint.fetchNowPlayingUrl)
        return moviesResponse
    }
}

class MovieDBServiceMock: MovieDBServiceProtocol {
    func fetchMovies() async throws -> MoviesResponse {
        
        let movies = [
            Movie(id: 1, title: "Movie title 1", posterPath: "jdfhgkjdfs.jpg"),
            Movie(id: 2, title: "Movie title 2", posterPath: "gdfgsfggsfd.jpg"),
            Movie(id: 3, title: "Movie title 3", posterPath: "gdfgseeesfd.jpg"),
            Movie(id: 4, title: "Movie title 4", posterPath: "gdfgsaaasfd.jpg"),
            Movie(id: 5, title: "Movie title 5", posterPath: "gdfgsbfdsfd.jpg")
        ]
        
        return MoviesResponse(results: movies,
                              totalPages: 1,
                              totalResults: movies.count)
    }
    
}

extension MovieDBService {
    private static func request<T: Decodable>(url: String, apiKey: String = TMDBEndpoint.apiKey) async throws -> T {
        guard let linkURL = URL(string: url) else {
            throw APIError.invalidUrl
        }
        
        var components = URLComponents(url: linkURL, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
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
