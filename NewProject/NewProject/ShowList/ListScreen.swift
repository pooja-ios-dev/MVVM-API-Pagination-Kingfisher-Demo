//
//  ListScreen.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI

struct ListScreen: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var path: [Movies] = []
    var body: some View {
        NavigationStack(path: $path) {
            content
                .navigationTitle("Movies")
                .onAppear {
                    Task {
                        viewModel.loadMovies()
                        
                    }
                }
                .navigationDestination(for: Movies.self) { movie in
                        Text(movie.title)
                    Button("go home") {
                        path.removeAll()
                    }
                    }
        }
    }
    
    @ViewBuilder
    private var content: some View  {
        if viewModel.isLoading {
            ProgressView()
        } else if let msg = viewModel.errorMessage {
            Text(msg)
        } else {
            movieList
        }
    }
    
    private var movieList: some View  {
        List { //movie in
            ForEach(viewModel.movies) { movie in
                NavigationLink(value: movie) {
                    //                Button(action: {
                    //                    path.append(movie)
                    //                }, label: {
                    HStack {
                        AsyncImage(url: URL(string: movie.poster ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 60, height: 80)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            
                            Text(movie.year)
                            Text(movie.runtime)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    //})
                }

                }
            
        }
        
    }
}

#Preview {
    ListScreen()
}
