//
//  HomeView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI
import Genre
import Core

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, GenreModel, Interactor<Any, [GenreModel],
        GetGenresRepository<GetGenresLocaleDataSource, GetGenresRemoteDataSource, GenreTransformer>>>
    
    var body: some View {
        
        ZStack {
            
            if presenter.isLoading {
                
            }
            
        }
    }
    
}

extension HomeView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading genres :D")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "Not Found",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyGenres: some View {
        CustomEmptyView(
            image: "Not Favorire",
            title: "The genres has fallen into an abyss :'("
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(
                self.presenter.list,
                id: \.id
            ) { genre in
                
                ZStack {
                    linkBuilder(for: genre) {
                        GenreRow(genre: genre)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(8)
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for genre: GenreModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: genre)
        ) { content() }
    }
    
}