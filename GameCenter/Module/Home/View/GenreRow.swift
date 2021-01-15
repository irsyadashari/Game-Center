//
//  GenreRow.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Genre

struct GenreRow: View {
    
    var genre: GenreModel
    
    var body: some View{
        VStack {
            imageGenre
            content
        }
    }
    
}

extension GenreRow {
    
    var imageGenre: some View {
        WebImage(url: URL(string: genre.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width,
                   height: 240,
                   alignment: .center)
            .mask(Jajargenjang(depth: 80))
    }
    
    var content: some View {
        
        Text(genre.name)
            .font(.title)
            .bold()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
    }
    
}
