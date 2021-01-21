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
        searchBar.barTintColor = UIColor(.baseColor)
        searchBar.tintColor = UIColor.black
        searchBar.isTranslucent = true
        searchBar.placeholder = "Grand Theft Auto..."
        searchBar.searchTextField.textColor = .white
        return searchBar
    }
    
    func updateUIView(
        _ uiView: UISearchBar,
        context: UIViewRepresentableContext<SearchBar>
    ) {
        uiView.text = text
    }
    
}
