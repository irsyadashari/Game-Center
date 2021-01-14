//
//  GameTransformer.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import RealmSwift

public struct GameTransformer<TagMapper: Mapper>: Mapper
where
    TagMapper.Request == String,
    TagMapper.Response == GameResponse,
    TagMapper.Entity == List<TagEntity>,
    TagMapper.Domain == [TagModel] {
    
    public typealias Request = String
    public typealias Response = GameResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameModel
    
    private let _tagMapper: TagMapper
    
    public init(tagMapper: TagMapper) {
        _tagMapper = tagMapper
    }
    
    public func transformResponseToEntity(request: String?, response: GameResponse) -> GameEntity {
        let tags = _tagMapper.transformResponseToEntity(request: request, response: response)
        
        let gameEntity = GameEntity()
        
        gameEntity.id = response.id ?? 0
        gameEntity.name = response.name ?? "Unknown"
        gameEntity.image = response.image ?? "Unknown"
        gameEntity.released = response.released ?? request ?? "Unknown"
        gameEntity.rating = response.rating ?? 0.0
        gameEntity.desc = response.desc ?? "Unknown"
        gameEntity.tags = tags
        
        if let genre = response.genres?.first?.name {
            gameEntity.genre = genre
        } else {
            gameEntity.genre = "Unknown"
        }
        
        return gameEntity
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameModel {
        let tags = _tagMapper.transformEntityToDomain(entity: entity.tags)
        
        return GameModel(
            id: entity.id,
            name: entity.name,
            image: entity.image,
            released: entity.released,
            rating: entity.rating,
            desc: entity.description,
            genre: entity.genre,
            tags: tags,
            favorite: entity.favorite
        )
    }
}


