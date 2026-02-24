//
//  BookViewModel.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI


class BookViewModel: ObservableObject {
    @Published var books: [Books] = []
    @Published var errorMsg: String?
    
    private let service: ApiLayer = ApiLayer()
    
    //@MainActor
    func loadBook() {
        Task {
            do {
                let fetchedBooks = try await service.fetchBooks(url: "https://my-json-server.typicode.com/ridoansaleh/books-api/books")
                await MainActor.run {
                    books = fetchedBooks
                }
            } catch let error as NetworksError {
                await MainActor.run {
                    switch error {
                    case .invalidUrl: errorMsg = "invalidUrl"
                    case .invalidResponse:
                        errorMsg = "invalidResponse"
                    case .noData:
                        errorMsg = "noData"
                    case .serverError(code: let code):
                        errorMsg = "serverError\(code)"
                    case .decodingError:
                        errorMsg = "decodingError"
                    }
                }
            } catch {
                await MainActor.run {
                    errorMsg = "unknown"
                }
            }
        }
    }
}
