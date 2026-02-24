//
//  ViewModel.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var movies: [Movies] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var service: ServiceCall = ServiceCall()
    
    func loadMovies() {
        Task {
            await MainActor.run  {
                isLoading = true
            }
            do {
                let fetchMovies = try await service.fetchMovies(url: "https://my-json-server.typicode.com/horizon-code-academy/fake-movies-api/movies")

                await MainActor.run  {
                    movies = fetchMovies
                }
            } catch let error as NetworkError {
                await MainActor.run  {
                    switch error {
                    case .invalidResponse:
                        errorMessage = "invalidResponse"
                    case .invalidUrl:
                        errorMessage = "invalidUrl"
                    case .noData:
                        errorMessage = "noData"
                    case .serverError:
                        errorMessage = "serverError"
                    }
                }
            } catch {
                await MainActor.run  {
                    errorMessage = "unknown error"
                }
            }
            await MainActor.run  {
                isLoading = false
            }
        }
    }
    
}
