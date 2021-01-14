//
//  DetailView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game
import Genre

struct DetailView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, GameModel, Interactor<String, [GameModel],
        GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource,
        GamesTransformer<GameTransformer<TagTransformer>>>>>
    
    var genre: GenreModel
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isLoading {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageGenre
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: genre.name)
            }
        }.navigationBarTitle(Text(genre.name), displayMode: .large)
    }
    
}

extension DetailView {
    
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading your genres :D")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "Not Found",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var imageGenre: some View {
        WebImage(url: URL(string: genre.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var gamesHorizontal: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(self.presenter.list, id: \.id) { game in
                    self.linkBuilder(for: game) {
                        GameRow(game: game)
                            .frame(width: 150, height: 150)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    func title(_ title: String) -> some View {
        return Text(genre.name)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            if !presenter.list.isEmpty {
                title("Games with \(genre.name) genre")
                    .padding(.bottom)
                gamesHorizontal
            }
            spacer
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
