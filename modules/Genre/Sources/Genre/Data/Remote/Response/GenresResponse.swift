//
//  GenresResponse.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation

public struct GenresResponse: Decodable {
    
    let genres: [GenreResponse]
    
    private enum CodingKeys: String, CodingKey {
        case genres = "results"
    }
    
}

public struct GenreResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image_background"
    }
    
    let id: Int?
    let name: String?
    let image: String?
    
}
