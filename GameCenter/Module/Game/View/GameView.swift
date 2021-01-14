//
//  GameView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game

struct GameView: View {
    
    @State var showingAlert = false
    
    @ObservedObject var presenter: GamePresenter<
        Interactor<String, GameModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource,
            GameTransformer<TagTransformer>>>,
        Interactor<String, GameModel, UpdateFavoriteGameRepository<GetFavoriteGamesLocaleDataSource,
            GameTransformer<TagTransformer>>>
    >
    
    var game: GameModel
    
    var body: some View {
        ZStack {
            
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageGame
                        content
                    }.padding()
                }
            }
        }.onAppear {
            self.presenter.getGame(request: String(game.id))
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Ow Ow"),
                message: Text("Something messed up!"),
                dismissButton: .default(Text("Okelah"))
            )
        }.navigationBarTitle(
            Text(presenter.item?.name ?? ""),
            displayMode: .automatic
        )
    }
    
}

extension GameView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Memuat Game :D")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "Not Found",
            title: presenter.errorMessage
        ).offset(y: 40)
    }
    
    var imageGame: some View {
        
        WebImage(url: URL(string: self.presenter.item?.image ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
            .cornerRadius(30)
        
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
           
            Text(self.presenter.item?.desc ?? "Failed to load description")
                .font(.system(size: 12))
            
            Divider()
                .padding(.vertical)
            
            if presenter.item?.tags.isEmpty == false {
                Text("Tags")
                    .font(.headline)
                
                ForEach(
                    self.presenter.item?.tags ?? [],
                    id: \.id)
                { tag in
                    ZStack {
                        Text(tag.name)
                            .font(.system(size: 12))
                    }
                }
            }
        }.padding(.top)
    }
}
