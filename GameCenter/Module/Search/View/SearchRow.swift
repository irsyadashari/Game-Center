//
//  SearchRow.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Game

struct SearchRow: View {
    
    var game: GameModel
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                imageGenre
                content
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8) 
        }
    }
}

extension SearchRow {
    var imageGenre: some View {
        WebImage(url: URL(string: game.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 120)
            .cornerRadius(20)
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(game.name)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .lineLimit(3)
                .foregroundColor(.white)
            Text("Released : \(game.released.formatDate())")
                .font(.system(size: 12))
                .lineLimit(2)
                .foregroundColor(.white)
            Text("Genre : \(game.genre)")
                .font(.system(size: 12))
                .lineLimit(2)
                .foregroundColor(.white)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
}
