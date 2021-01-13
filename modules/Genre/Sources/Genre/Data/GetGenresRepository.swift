//
//  GetGenresRepository.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine

public struct GetGenresRepository<
    GenreLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GenreLocaleDataSource.Response == GenreEntity,
    RemoteDataSource.Response == [GenreResponse],
    Transformer.Response == [GenreResponse],
    Transformer.Entity == [GenreEntity],
    Transformer.Domain == [GenreModel] {
    
    public typealias Request = Any
    public typealias Response = [GenreModel]
    private let _localeDataSource: GenreLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GenreLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GenreModel], Error> {
        return _localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[GenreModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: nil)
                        .map { _mapper.transformResponseToEntity(request: nil, response: $0) }
                        .catch { _ in _localeDataSource.list(request: nil) }
                        .flatMap { _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.list(request: nil)
                            .map { _mapper.transformEntityToDomain(entity: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return _localeDataSource.list(request: nil)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

