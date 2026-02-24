//
//  BookView.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI


struct BookView: View {
    @StateObject var vm: BookViewModel = BookViewModel()
    var body: some View {
        NavigationStack {
            if let msg = vm.errorMsg {
                Text(msg)
            } else {
                List {
                    ForEach(vm.books) { book in
                        HStack {
                            AsyncImage(url: URL(string:book.cover)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.green
                            }
                        }
                        VStack {
                            Text(book.title)
                                .font(.title)
                            Text(book.year)
                                .font(.caption)
                        }
                    }
                }
                .navigationTitle("Books")
                .onAppear {
                    vm.loadBook()
                }
            }
        }
    }
}

#Preview {
    BookView()
}
