//
//  IconInfo.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 18/01/21.
//

import SwiftUI

struct IconInfo: View {
    var image: String
    var info: String
    
    var body: some View {
        HStack(spacing: 8) {
            
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(info)
                .font(.system(size: 16))
                .foregroundColor(.white)
            
        }
    }
}
