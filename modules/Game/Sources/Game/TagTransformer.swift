//
//  TagTransformer.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import RealmSwift

public struct TagTransformer: Mapper {
    
    public typealias Request = String
    public typealias Response = GameResponse
    public typealias Entity = List<TagEntity>
    public typealias Domain = [TagModel]
    
    public init() { }
    
    public func transformResponseToEntity(request: String?, response: GameResponse) -> List<TagEntity> {
        let tagEntities = List<TagEntity>()
        
        if let tags = response.tags {
            
            for item in tags {
                let entity = TagEntity()
                entity.id = item.id
                entity.name = item.name
                tagEntities.append(entity)
            }
        }
        
        return tagEntities
    }
    
    public func transformEntityToDomain(entity: List<TagEntity>) -> [TagModel] {
        return entity.map { result in
            return TagModel(
                id: result.id, name: result.name
            )
        }
    }
    
}
