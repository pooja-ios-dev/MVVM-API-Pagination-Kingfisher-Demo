//
//  photosModel.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 12/02/26.
//

import Foundation

struct Photos: Codable, Identifiable {
    
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String
  
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
}
