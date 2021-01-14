//
//  HomeRouter.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import Genre
import Core
import Game

class HomeRouter {
    
    func makeDetailView(for genre: GenreModel) -> some View {
        
        let useCase: Interactor<
            String,
            [GameModel],
            GetGamesRepository<
                GetGamesLocaleDataSource,
                GetGamesRemoteDataSource,
                GamesTransformer<GameTransformer<TagTransformer>>>
        > = Injection.init().provideGames()
        
        let presenter = GetListPresenter(useCase: useCase)
        
        return DetailView(presenter: presenter, genre: genre)
    }
    
}
