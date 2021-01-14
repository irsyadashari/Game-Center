//
//  APICall.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation

struct API {
    
    static let baseUrl = "https://api.rawg.io/api"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case genres
        case games
        case game
        case search
        
        public var url: String {
            switch self {
                case .genres: return "\(API.baseUrl)/genres"
                case .games: return "\(API.baseUrl)/games"
                case .game: return "\(API.baseUrl)games/"
                case .search: return "\(API.baseUrl)?search="
            }
        }
    }
    
}
