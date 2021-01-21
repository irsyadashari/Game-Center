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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
            
            Color.baseColor
                .edgesIgnoringSafeArea(.all)
            
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageGame
                        content
                    }
                    .padding()
                    .offset(y: -60) // to make the image all the way to top of the head
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Ow Ow"),
                message: Text("Something messed up!"),
                dismissButton: .default(Text("Okelah"))
            )
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .overlay(
            VStack {
                HStack {
                    btnBack
                        .padding()
                    spacer
                }
                spacer
            }
        )
    }
    
}

extension GameView {
    
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
            Text("Memuat Game :D")
                .foregroundColor(.white)
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
        
        WebImage(url: URL(string: self.game.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width,
                   height: 300,
                   alignment: .center)
            .edgesIgnoringSafeArea(.top)
            .overlay(
                faveBtn
            )
        
    }
    
    var faveBtn: some View {
        VStack {
            spacer
            HStack {
                spacer
                
                if self.presenter.item?.favorite == true {
                    CustomIcon(
                        imageName: "heart.fill"
                    ).onTapGesture { self.presenter.updateFavoriteGame(request: String(game.id))}
                } else {
                    CustomIcon(
                        imageName: "heart"
                    ).onTapGesture { self.presenter.updateFavoriteGame(request: String(game.id))}
                }
            }
        }
    }
    
    var ratingsAndTitle: some View {
        HStack (spacing: 2){
            Text(
                self.game
                    .name
                    .parse() )
                .padding(.leading)
                .font(.system(size: 40, weight: .semibold, design: .serif))
                .foregroundColor(.white)
            
            
            CustomIcon(imageName: "star.fill", color: .yellow)
            Text(String(self.game.rating))
                .font(.system(size: 24, weight: .semibold, design: .serif))
                .foregroundColor(.white)
            
        }
        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
    }
    
    var releasedDates: some View {
        
        Text("Released : \(self.game.released.formatDate())")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
            .padding(.leading)
        
    }
    
    var gameDesc: some View {
        
        Text(
            self.presenter
                .item?
                .desc
                .parse() ?? "failed to load description")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
            .padding(.leading)
        
    }
    
    var tags: some View {
        
        VStack {
            if game.tags.isEmpty == false {
                Text("Tags")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
                    .padding()
                
                let layout = [
                    GridItem(.adaptive(minimum: 100))
                ]
                
                LazyVGrid(columns: layout, spacing: 4) {
                    ForEach(
                        self.game.tags,
                        id: \.id)
                    { tag in
                        ZStack {
                            Capsule()
                                .fill(Color.yellow)
                                .frame(height: 50)
                                .cornerRadius(4)
                            Text(tag.name)
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                        }
                        .padding(
                            EdgeInsets(
                                top: 4,
                                leading: 4,
                                bottom: 4,
                                trailing: 4
                            )
                        )
                    }
                }
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            ratingsAndTitle
            releasedDates
            gameDesc
            
            Divider()
                .padding(.vertical)
            
            tags
        }.padding(.top).onAppear(perform: {
            if self.presenter.item == nil {
                self.presenter.getGame(request: String(game.id))
            }
        })
    }
}
