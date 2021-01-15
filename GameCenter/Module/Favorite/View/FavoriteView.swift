//
//  FavoriteView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import Core
import Game

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, GameModel, Interactor<String, [GameModel],
        GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource,
        GamesTransformer<GameTransformer<TagTransformer>>>>>
    
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.count == 0 {
                emptyFavorites
            } else {
                content
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(
            Text("Favorite Games"),
            displayMode: .automatic
        )
    }
}

extension FavoriteView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading your favo game :D")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "No Favorite",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyFavorites: some View {
        CustomEmptyView(
            image: "No Favorite",
            title: "Shoot some of your fave game first lads!"
        )
    }
    
    var content: some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            ForEach(
                self.presenter.list,
                id: \.id
            ) { game in
                ZStack {
                    self.linkBuilder(for: game) {
                        FavoriteRow(game: game)
                    }.buttonStyle(PlainButtonStyle())
                }
                
            }
        }
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
