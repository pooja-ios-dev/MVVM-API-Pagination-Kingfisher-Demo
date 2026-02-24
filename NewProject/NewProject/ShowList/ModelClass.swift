//
//  ModelClass.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI

struct Movies: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let year: String
    let poster: String?
    let runtime: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case runtime = "Runtime"
    }
}
