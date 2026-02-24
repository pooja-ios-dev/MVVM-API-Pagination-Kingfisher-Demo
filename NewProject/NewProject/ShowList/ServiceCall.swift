//
//  ServiceCall.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI
enum NetworkError: Error {
    case invalidUrl
    case noData
    case invalidResponse
    case serverError
}

class ServiceCall {
    
    func fetchMovies(url: String) async throws -> [Movies] {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError
        }
        
        do {
            return try JSONDecoder().decode([Movies].self, from: data)
//            decoded = decoded.map { movie in
//                Movies(title: movie.title, year: movie.year, poster: movie.poster, runtime: movie.runtime)
//            }
//            return decoded
        } catch {
            throw NetworkError.noData
        }
    }
       
}
