//
//  GetGamesLocaleDataSource.swift
//  
//
//  Created by Irsyad Ashari on 13/01/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetGamesLocaleDataSource : LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            guard let request  = request else { return completion(.failure(DatabaseError.requestFailed)) }
            
            let games: Results<GameEntity> = {
                _realm.objects(GameEntity.self)
                    .filter("game = '\(request)'")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            
            completion(.success(games.toArray(ofType: GameEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            
            do {
                try _realm.write {
                    for game in entities {
                        _realm.add(game, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            
            let games: Results<GameEntity> = {
                _realm.objects(GameEntity.self)
                    .filter("id = '\(id)'")
            }()
            
            guard let game = games.first else {
                completion(.failure(DatabaseError.requestFailed))
                return
            }
            
            completion(.success(game))
            
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let gameEntity = {
                _realm.objects(GameEntity.self).filter("id = '\(id)'")
            }().first {
                do {
                    try _realm.write {
                        gameEntity.setValue(entity.name, forKey: "name")
                        gameEntity.setValue(entity.image, forKey: "image")
                        gameEntity.setValue(entity.desc, forKey: "desc")
                        gameEntity.setValue(entity.released, forKey: "released")
                        gameEntity.setValue(entity.rating, forKey: "rating")
                        gameEntity.setValue(entity.favorite, forKey: "favorite")
                        gameEntity.setValue(entity.tags, forKey: "tags")
                    }
                    completion(.success(true))
                    
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
