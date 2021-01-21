//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core

public struct GamesTransformer<GameMapper: Mapper>: Mapper
where
    GameMapper.Request == String,
    GameMapper.Response == GameResponse,
    GameMapper.Entity == GameEntity,
    GameMapper.Domain == GameModel {
    public typealias Request = String
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameModel]
    private let _gameMapper: GameMapper
    public init(gameMapper: GameMapper) {
        _gameMapper = gameMapper
    }
    public func transformResponseToEntity(request: String?, response: [GameResponse]) -> [GameEntity] {
        return response.map { result in
            _gameMapper.transformResponseToEntity(request: request, response: result)
        }
    }
    public func transformEntityToDomain(entity: [GameEntity]) -> [GameModel] {
        return entity.map { result in
            return _gameMapper.transformEntityToDomain(entity: result)
        }
    }
}
