//
//  GetGamesRepository.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine

public struct GetGamesRepository<
    GameLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GameLocaleDataSource.Request == String,
    GameLocaleDataSource.Response == GameEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [GameResponse],
    Transformer.Request == String,
    Transformer.Response == [GameResponse],
    Transformer.Entity == [GameEntity],
    Transformer.Domain == [GameModel] {
    
    public typealias Request = String
    public typealias Response = [GameModel]
    
    private let _localeDataSource: GameLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[GameModel], Error> {
        return _localeDataSource.list(request: request)
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                        .catch { _ in _localeDataSource.list(request: request) }
                        .flatMap {  _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.list(request: request)
                            .map {  _mapper.transformEntityToDomain(entity: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return _localeDataSource.list(request: request)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

