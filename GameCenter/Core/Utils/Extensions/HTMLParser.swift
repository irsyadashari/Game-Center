//
//  HTMLParser.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 15/01/21.
//

import Foundation

public class HTMLParser {
    
    class func parse(string: String) -> String {
      return string.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
    }
    
}
