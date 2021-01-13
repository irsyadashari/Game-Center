//
//  SearchGamesRepository.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine

public struct SearchGamesRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [GameResponse],
    Transformer.Request == String,
    Transformer.Response == [GameResponse],
    Transformer.Entity == [GameEntity],
    Transformer.Domain == [GameModel] {
    
    public typealias Request = String
    public typealias Response = [GameModel]
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[GameModel], Error> {
        
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        
    }
}

