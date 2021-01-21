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
        VStack {
            imageGame
            titleGame
        }
    }
}

extension GameRow {
    var imageGame: some View {
        WebImage(url: URL(string: self.game.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width,
                   height: 240,
                   alignment: .center)
            .mask(Jajargenjang(depth: 80))
    }
    var titleGame: some View {
        Text(self.game.name)
            .font(.title)
            .bold()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .trailing)
            .rotationEffect(Angle(degrees: -12))
            .offset(y: -16)
    }
}
