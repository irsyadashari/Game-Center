//
//  ContentView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 13/01/21.
//

import SwiftUI
import Game
import Genre
import Core

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: GetListPresenter<Any, GenreModel, Interactor<Any, [GenreModel],
        GetGenresRepository<GetGenresLocaleDataSource, GetGenresRemoteDataSource, GenreTransformer>>>
    
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, GameModel, Interactor<String, [GameModel],
        GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource,
        GamesTransformer<GameTransformer<TagTransformer>>>>>
    
    @EnvironmentObject var searchPresenter: SearchPresenter<GameModel, Interactor<String, [GameModel],
        SearchGamesRepository<GetGamesRemoteDataSource, GamesTransformer<GameTransformer<TagTransformer>>>>>
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationView {
                SearchView(presenter: searchPresenter)
            }.tabItem {
                TabItem(imageName: "magnifyingglass", title: "Search")
            }
            
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
        }
    }
}
