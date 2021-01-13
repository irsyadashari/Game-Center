//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Foundation
import RealmSwift

public class GenreEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}

