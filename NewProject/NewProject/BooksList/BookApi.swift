//
//  BookApi.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI

enum NetworksError: Error, Hashable {
    case invalidUrl
    case invalidResponse
    case noData
    case serverError(code: Int)
    case decodingError
}
class ApiLayer {
    
    func fetchBooks(url: String) async throws -> [Books] {
        guard let url = URL(string: url) else {
            throw NetworksError.invalidUrl
        }
        
        let (data, res) = try await URLSession.shared.data(from: url)
        
        guard let httpres = res as? HTTPURLResponse else {
            throw NetworksError.invalidResponse
        }
        
        guard 200..<300 ~= httpres.statusCode else {
            throw NetworksError.serverError(code: httpres.statusCode)
        }
        
        if data.isEmpty {
            throw NetworksError.noData
        }
        do {
            return try JSONDecoder().decode([Books].self, from: data)
        } catch {
            throw NetworksError.decodingError
        }
    }
}
