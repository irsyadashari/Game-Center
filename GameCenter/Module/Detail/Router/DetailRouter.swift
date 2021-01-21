//
//  DetailRouter.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import Genre
import Core
import Game

class DetailRouter {
    func makeGameView(for game: GameModel) -> some View {
        let useCase: Interactor<
            String,
            GameModel,
            GetGameRepository<
                GetGamesLocaleDataSource,
                GetGameRemoteDataSource,
                GameTransformer<TagTransformer>>
        > = Injection.init().provideGame()
        let favoriteUseCase: Interactor<
            String,
            GameModel,
            UpdateFavoriteGameRepository<
                GetFavoriteGamesLocaleDataSource,
                GameTransformer<TagTransformer>>
        > = Injection.init().provideUpdateFavorite()
        let presenter = GamePresenter(gameUseCase: useCase, favoriteUseCase: favoriteUseCase)
        return GameView(presenter: presenter, game: game)
    }
}
