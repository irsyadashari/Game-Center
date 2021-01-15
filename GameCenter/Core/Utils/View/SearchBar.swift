//
//  SearchBar.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)?


    class Coordinator: NSObject, UISearchBarDelegate {
        
        let control: SearchBar
        
        init(_ control: SearchBar) {
            self.control = control
        }
        
        func searchBar(
            _ searchBar: UISearchBar,
            textDidChange searchText: String
        ) {
            control.text = searchText
        }
        
        func searchBarSearchButtonClicked(
            _ searchBar: UISearchBar
        ) {
            control.onSearchButtonClicked?()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(
        context: UIViewRepresentableContext<SearchBar>
    ) -> UISearchBar {
        let searchBar = UISearchBar(frame:.zero)
        searchBar.delegate = context.coordinator
        searchBar.barTintColor = UIColor.black
        searchBar.tintColor = UIColor.white
//        searchBar.isTranslucent = true
//        searchBar.barStyle = .black
        return searchBar
    }
    
    func updateUIView(
        _ uiView: UISearchBar,
        context: UIViewRepresentableContext<SearchBar>
    ) {
        uiView.text = text
    }
    
}
