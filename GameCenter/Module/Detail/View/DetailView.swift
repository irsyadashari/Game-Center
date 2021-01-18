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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var presenter: GetListPresenter<String, GameModel, Interactor<String, [GameModel],
        GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource,
        GamesTransformer<GameTransformer<TagTransformer>>>>>
    
    var genre: GenreModel
    
    var body: some View {
        ZStack {
            
            Color.baseColor
                .edgesIgnoringSafeArea(.all)
            
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isLoading {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageGenre
                        Divider()
                            .padding()
                        content
                    }.offset(y: -60)
                }
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: genre.name)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .overlay(
            VStack {
                HStack {
                    btnBack
                        .padding(8)
                    spacer
                }
                spacer
            }
        )
    }
    
}

extension DetailView {
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
            Image("iconsBack") // set image here
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
        }
    }
    
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading your genres :D")
                .foregroundColor(.white)
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
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width,
                   height: 300,
                   alignment: .center)
            .edgesIgnoringSafeArea(.top)
            
    }
    
    func title(_ title: String) -> some View {
        return Text(title)
            .foregroundColor(.white)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .center, spacing: 0) {
            
            if !presenter.list.isEmpty {
                title("Games with \(genre.name) genre")
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 24,
                            trailing: 0))
                gamesVertical
            }
        }
    }
    
    var gamesVertical: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            ForEach(self.presenter.list,
                    id: \.id
            ) { game in
                ZStack {
                    self.linkBuilder(for: game) {
                        GameRow(game: game)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(8)
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
