//
//  GetFavoriteGamesLocaleDataSource.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetFavoriteGamesLocaleDataSource : LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            
            let gameEntities = {
                _realm.objects(GameEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(gameEntities.toArray(ofType: GameEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        
        return Future<GameEntity, Error> { completion in
            if let gameEntity = {
                _realm.objects(GameEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        gameEntity.setValue(!gameEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(gameEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

