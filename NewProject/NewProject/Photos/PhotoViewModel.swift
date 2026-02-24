//
//  PhotoViewModel.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 12/02/26.
//

import Foundation

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photos] = []
    @Published var errorMsg: String?
    @Published var isLoading: Bool = false
    @Published var page = 1
    
    private var service: PhotoService = PhotoService()
    
    @MainActor
    func loadMoreIfNeeded(current: Photos) {
        guard let last = photos.last else { return }
        
        if current.id == last.id {
            loadPhotos()
        }
    }
    
    @MainActor
    func loadPhotos() {
        Task {
            isLoading = true
            
            do {
                let newPhotos = try await service.fetchPhotos(url: "https://picsum.photos/v2/list?page=\(page)&limit=10")
                photos.append(contentsOf: newPhotos)
                print("page: \(page)")
                page += 1
                isLoading = false
            } catch let error as NetworksError {
                switch error {
                case .invalidUrl: errorMsg = "invalidUrl"
                case .invalidResponse:
                    errorMsg = "invalidResponse"
                case .noData:
                    errorMsg = "noData"
                case .serverError(code: let code):
                    errorMsg = "serverError \(code)"
                case .decodingError:
                    errorMsg = "decodingError"
                }
            } catch {
                errorMsg = "Unknown"
            }
            
            isLoading = false
        }
    }
}
