//
//  GameEntity.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.


import Foundation
import RealmSwift

public class GameEntity: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var released = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var desc = ""
    @objc dynamic var favorite = false
    
    var tags = List<TagEntity>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
