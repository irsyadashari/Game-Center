//
//  SceneDelegate.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 13/01/21.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Genre
import Game

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let injection = Injection()
        let favoriteUseCase: Interactor<
            String,
            [GameModel],
            GetFavoriteGamesRepository<
                GetFavoriteGamesLocaleDataSource,
                GamesTransformer<GameTransformer<TagTransformer>>>
        > = injection.provideFavorite()
        let searchUseCase: Interactor<
            String,
            [GameModel],
            SearchGamesRepository<
                GetGamesRemoteDataSource,
                GamesTransformer<GameTransformer<TagTransformer>>>
        > = injection.provideSearch()
        let genreUseCase: Interactor<
            Any,
            [GenreModel],
            GetGenresRepository<
                GetGenresLocaleDataSource,
            GetGenresRemoteDataSource,
            GenreTransformer>
        > = injection.provideGenre()
        let homePresenter = GetListPresenter(useCase: genreUseCase)
        let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
        let searchPresenter = SearchPresenter(useCase: searchUseCase)
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
            .environmentObject(searchPresenter)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
