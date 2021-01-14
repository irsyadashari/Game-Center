//
//  GameRow.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Game

struct GameRow: View {
    
    var game: GameModel
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                self.imageGame
                    .frame(width: geometry.size.width,
                           height: geometry.size.height,
                           alignment: .center
                    )
                self.blurView
                    .frame(
                        width: geometry.size.width,
                        height: 32
                    )
                self.titleGame
            }
        }.cornerRadius(12)
    }
}

extension GameRow {
    
    var blurView: some View {
        BlurView()
    }
    
    var imageGame: some View {
        WebImage(url: URL(string: self.game.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
    }
    
    var titleGame: some View {
        Text(self.game.name)
            .font(.system(size: 14))
            .lineLimit(1)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
    }
    
}
