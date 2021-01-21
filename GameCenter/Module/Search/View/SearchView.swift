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
        
        ZStack {
            Color.baseColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                SearchBar(
                    text: $presenter.keyword,
                    onSearchButtonClicked: presenter.search
                ).foregroundColor(.black)
                
                Spacer()
                
                ZStack {
                    
                    if presenter.isLoading {
                        loadingIndicator
                    } else if presenter.keyword.isEmpty {
                        emptyTitle
                    } else if presenter.list.isEmpty {
                        emptyGames
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
                
            }
            .navigationBarTitle(
                Text("Search Games"),
                displayMode: .automatic
            )
        }
    }
}

extension SearchView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
                .foregroundColor(.white)
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "Not Found",
            title: presenter.errorMessage
        )
    }
    
    var emptyTitle: some View {
        CustomEmptyView(
            image: "search",
            title: "Come on, find your game lads!"
        )
    }
    var emptyGames: some View {
        CustomEmptyView(
            image: "Not Found",
            title: "Data not found"
        )
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

