//
//  ActivityIndicator.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  
    func makeUIView(
        context: UIViewRepresentableContext<ActivityIndicator>
    ) -> UIActivityIndicatorView {
        let loadingBar = UIActivityIndicatorView(style: .large)
        loadingBar.tintColor = .white
        loadingBar.color = .white
        return loadingBar
    }
    
    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>
    ) {
        uiView.startAnimating()
    }
}
