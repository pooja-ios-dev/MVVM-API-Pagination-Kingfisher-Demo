//
//  PhotoService.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 12/02/26.
//

import Foundation

class PhotoService {
    
    func fetchPhotos(url: String) async throws -> [Photos] {
        guard let url = URL(string: url) else {
            throw NetworksError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworksError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworksError.serverError(code: httpResponse.statusCode)
        }
        
        if data.isEmpty {
            throw NetworksError.noData
        }
        
        do {
            return try JSONDecoder().decode([Photos].self, from: data)
        } catch {
            throw NetworksError.decodingError
        }
    }
}
