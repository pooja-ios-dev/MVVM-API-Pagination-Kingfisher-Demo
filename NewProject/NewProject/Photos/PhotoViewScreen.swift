//
//  PhotoViewScreen.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 12/02/26.
//

import SwiftUI
import Kingfisher

struct PhotoViewScreen: View {
    @StateObject var vm: PhotoViewModel = PhotoViewModel()
    var body: some View {
        NavigationStack {
            imageCache
                .navigationTitle("Photos")
                .onAppear {
                    vm.loadPhotos()
                }
        }
    }
    
    @ViewBuilder
    var imageCache: some View {
        if vm.isLoading {
            ProgressView()
        } else if let msg = vm.errorMsg {
            Text(msg)
        } else {
            List(vm.photos, id: \.id) { photo in
                HStack {
//                    AsyncImage(url: URL(string: photo.downloadUrl)) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(width: 50, height: 50)
//                    .scaledToFill()
//                    .cornerRadius(30)
                    KFImage(URL(string: photo.downloadUrl))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaledToFill()
                        .cornerRadius(30)
                    
                    VStack {
                        Text(photo.author)
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                        
                        Text("\(photo.width), \(photo.height)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading,40)
                }
                .onAppear {
                    vm.loadMoreIfNeeded(current: photo)
                }
            }
        }
    }
}

#Preview {
    PhotoViewScreen()
}
