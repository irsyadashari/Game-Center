//
//  View+Ext.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 15/01/21.
//

import SwiftUI

extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }
    
    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
