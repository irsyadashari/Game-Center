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

let navStyle = UINavigationBarAppearance()

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<Any, GenreModel, Interactor<Any, [GenreModel],
        GetGenresRepository<GetGenresLocaleDataSource, GetGenresRemoteDataSource, GenreTransformer>>>
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, GameModel, Interactor<String, [GameModel],
        GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource,
        GamesTransformer<GameTransformer<TagTransformer>>>>>
    @EnvironmentObject var searchPresenter: SearchPresenter<GameModel, Interactor<String, [GameModel],
        SearchGamesRepository<GetGamesRemoteDataSource, GamesTransformer<GameTransformer<TagTransformer>>>>>
    init() {
        setupStyleBar()
    }
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
            NavigationView {
               ProfileView()
            }.tabItem {
                TabItem(imageName: "person", title: "Profile")
            }
        }.accentColor(.white)
    }
}

extension ContentView {
    func setupStyleBar() {
        UITabBar.appearance().barTintColor = UIColor(.baseColor)
        UITabBar.appearance().tintColor = .yellow
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().isTranslucent = true
        navStyle.configureWithTransparentBackground()
        navStyle.backgroundColor = UIColor(.baseColor)
        navStyle.titleTextAttributes = [.foregroundColor: UIColor.white]
        navStyle.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navStyle
        UINavigationBar.appearance().scrollEdgeAppearance = navStyle
    }
}
