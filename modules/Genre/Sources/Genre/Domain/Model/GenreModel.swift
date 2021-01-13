//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation

public struct GenreModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    public let image: String
    
    public init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
