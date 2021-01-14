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
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding(.top)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(genre.name)
                .font(.title)
                .bold()
            
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
