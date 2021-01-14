//
//  SearchView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import Core
import Game

struct SearchView: View {
    
    @ObservedObject var presenter: SearchPresenter<GameModel, Interactor<String, [GameModel], SearchGamesRepository<GetGamesRemoteDataSource, GamesTransformer<GameTransformer<TagTransformer>>>>>
    
    var body: some View {
        VStack {
            SearchBar(
                text: $presenter.keyword,
                onSearchButtonClicked: presenter.search
            )
            
            ZStack {
                if presenter.isLoading {
                    loadingIndicator
                } else if presenter.keyword.isEmpty {
                    emptyTitle
                } else if presenter.list.isEmpty {
                    emptyMeals
                } else if presenter.isError {
                    errorIndicator
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.list,
                            id: \.id
                        ) { game in
                            ZStack {
                                self.linkBuilder(for: game) {
                                    SearchRow(game: game)
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(8)
                        }
                    }
                }
            }
            Spacer()
        }.navigationBarTitle(
            Text("Search Games"),
            displayMode: .automatic
        )
    }
}

extension SearchView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "No Favorite",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyTitle: some View {
        CustomEmptyView(
            image: "No Favorite",
            title: "Come on, find your favorite food!"
        ).offset(y: 50)
    }
    var emptyMeals: some View {
        CustomEmptyView(
            image: "No Favorite",
            title: "Data not found"
        ).offset(y: 80)
    }
    
    func linkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: DetailRouter().makeGameView(for: game)
        ) { content() }
    }
}

