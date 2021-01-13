//
//  GenreTransformer.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core

public struct GenreTransformer: Mapper {
    public typealias Request = Any
    public typealias Response = [GenreResponse]
    public typealias Entity = [GenreEntity]
    public typealias Domain = [GenreModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: Any?, response: [GenreResponse]) -> [GenreEntity] {
        return response.map { result in
            let newGenre = GenreEntity()
            newGenre.id = result.id ?? 0
            newGenre.name = result.name ?? "Unknown"
            newGenre.image = result.image ?? "Unknown"
            return newGenre
        }
    }
    
    public func transformEntityToDomain(entity: [GenreEntity]) -> [GenreModel] {
        return entity.map { result in
            return GenreModel(
                id: Int(result.id),
                name: result.name,
                image: result.image
            )
        }
    }
}
