//
//  TabItem.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 14/01/21.
//

import SwiftUI

struct TabItem: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
}
