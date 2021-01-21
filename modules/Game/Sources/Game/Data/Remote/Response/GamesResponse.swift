//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation

public struct GamesResponse: Decodable {
    
    let games: [GameResponse]
    
    private enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

public struct GameResponse: Decodable {
    
    let id: Int?
    let name: String?
    let image: String?
    let released: String?
    let rating: Double?
    let desc: String?
    let tags: [Tag]?
    let genres: [GenreResponse]?
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case image = "background_image"
        case released
        case rating
        case desc = "description"
        case tags
        case genres
    }
}

public struct Tag: Codable {
    public let id: Int
    public let name: String
}

public struct GenreResponse: Codable {
    public let id: Int
    public let name: String
}

