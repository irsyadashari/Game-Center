//
//  BlurView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    func makeUIView(
        context: UIViewRepresentableContext<BlurView>
    ) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let blurFX = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurFX)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }

    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<BlurView>
    ) {}
    
}
