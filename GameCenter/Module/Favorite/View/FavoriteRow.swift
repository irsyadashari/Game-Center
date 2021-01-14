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
                
            }
            
        }
        
    }
    
}

extension FavoriteRow {
    
    var imageGenre: some View {
        WebImage(url: URL(string: game.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 120)
            .cornerRadius(20)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(game.name)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .lineLimit(3)
            
            Text("Release Date : \(game.released)")
                .font(.system(size: 16))
                .lineLimit(2)
            
            Text(game.desc)
                .font(.system(size: 16))
                .lineLimit(2)
            
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
