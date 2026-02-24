//
//  Books.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import Foundation

struct Books: Codable, Identifiable {
    var id = UUID()
    let title: String
    let author: String
    let cover: String
    let year: String
}
