//
//  CustomEmptyView.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI

struct CustomEmptyView: View {
    var image: String
    var title: String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(title)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.white)
        }
    }
}
