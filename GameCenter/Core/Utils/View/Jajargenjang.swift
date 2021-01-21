//
//  Jajargenjang.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 15/01/21.
//

import SwiftUI

struct Jajargenjang: Shape {
    var depth: CGFloat
    var flipped: Bool = false
    func path(in rect: CGRect) -> Path {
        Path { path in
            if flipped {
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: depth))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height - depth))
            } else {
                path.move(to: CGPoint(x: 0, y: depth))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height - depth))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
            }
            path.closeSubpath()
        }
    }
}
