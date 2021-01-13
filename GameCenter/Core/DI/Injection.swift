//
//  Injection.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 13/01/21.
//

import UIKit
import Genre
import Core
import Game

final class Injection: NSObject {
    
    func provideGenre<U: UseCase>() -> U where U.Request == Any, U.Response == [GenreModel] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetGenresLocaleDataSource(realm: appDelegate.realm)
        let remote = GetGenresRemoteDataSource(endpoint: Endpoints.Gets.genres.url)
        let mapper = GenreTransformer()
        
        let repository = GetGenresRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGames<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetGamesLocaleDataSource(realm: appDelegate.realm)
        let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.genres.url)
        
        let tagMapper = TagTransformer()
        let gameMapper = GameTransformer(tagMapper: tagMapper)
        let mapper = GamesTransformer(gameMapper: gameMapper)
        
        let repository = GetGamesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        
        let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.genres.url)
        
        let tagMapper = TagTransformer()
        let gameMapper = GameTransformer(tagMapper: tagMapper)
        let mapper = GamesTransformer(gameMapper: gameMapper)
        
        let repository = SearchGamesRepository(remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGame<U: UseCase>() -> U where U.Request == String, U.Response == GameModel {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetGamesLocaleDataSource(realm: appDelegate.realm)
        let remote = GetGameRemoteDataSource(endpoint: Endpoints.Gets.game.url)
        
        let tagMapper = TagTransformer()
        let mapper = GameTransformer(tagMapper: tagMapper)
       
        let repository = GetGameRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == GameModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetFavoriteGamesLocaleDataSource(realm: appDelegate.realm)
        
        let tagMapper = TagTransformer()
        let mapper = GameTransformer(tagMapper: tagMapper)
        
        let repository = UpdateFavoriteGameRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = GetFavoriteGamesLocaleDataSource(realm: appDelegate.realm)
        
        let tagMapper = TagTransformer()
        let gameMapper = GameTransformer(tagMapper: tagMapper)
        let mapper = GamesTransformer(gameMapper: gameMapper)
        
        let repository = GetFavoriteGamesRepository(
            localeDataSource: locale,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
}
