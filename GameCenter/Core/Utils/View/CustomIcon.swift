//
//  CustomIcon.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 15/01/21.
//

import SwiftUI

struct CustomIcon: View {
    
    var imageName: String
    var color: Color = Color.white
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(color)
        }
        .padding()
    }
    
}
