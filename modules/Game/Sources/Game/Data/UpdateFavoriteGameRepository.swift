//
//  UpdateFavoriteGameRepository.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine

public struct UpdateFavoriteGameRepository<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    GameLocaleDataSource.Request == String,
    GameLocaleDataSource.Response == GameEntity,
    Transformer.Request == String,
    Transformer.Response == GameResponse,
    Transformer.Entity == GameEntity,
    Transformer.Domain == GameModel {
    
    public typealias Request = String
    public typealias Response = GameModel
    
    private let _localeDataSource: GameLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<GameModel, Error> {
        return _localeDataSource.get(id: Int(request ?? "") ?? 0)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
