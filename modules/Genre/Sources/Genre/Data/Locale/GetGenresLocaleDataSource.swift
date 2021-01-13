//
//  GetGenresLocaleDataSource.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetGenresLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    
    public typealias Response = GenreEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GenreEntity], Error> {
        return Future<[GenreEntity], Error> { completion in
            let genres: Results<GenreEntity> = {
                _realm.objects(GenreEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(genres.toArray(ofType: GenreEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GenreEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for genre in entities {
                        _realm.add(genre, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<GenreEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: GenreEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

