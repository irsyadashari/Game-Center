//
//  FavoriteRow.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game

struct FavoriteRow: View {
    
    var game: GameModel
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top) {
                imageGame
                content
            }
            .frame(width: UIScreen.main.bounds.width - 32,
                   height: 120)
        }
        
    }
    
}

extension FavoriteRow {
    
    var imageGame: some View {
        WebImage(url: URL(string: game.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 120, height: 120)
            .cornerRadius(20)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(game.name)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(3)
            
            Text("Released : \(game.released.formatDate())")
                .foregroundColor(.white)
                .font(.system(size: 12))
                .lineLimit(2)
            
            Text(game.desc.parse())
                .frame(height: 60)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .lineLimit(3)
                .lineSpacing(1)
            
            Spacer()
            
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
