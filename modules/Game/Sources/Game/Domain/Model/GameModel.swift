//
//  GameModel.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    public let image: String
    public var released: String = ""
    public var rating: Double = 0.0
    public var desc: String = ""
    public var genre: String = ""
    public var tags: [TagModel] = []
    public var favorite: Bool = false
    
}
