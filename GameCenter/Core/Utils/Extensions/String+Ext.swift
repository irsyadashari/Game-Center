//
//  String+Ext.swift
//  GameCenter
//
//  Created by Irsyad Ashari on 15/01/21.
//

import Foundation

extension String {
    
    func formatDate()-> String{
        
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateObj = dateFormatter.date(from: self)
        
        if let date = dateObj {
            let year = calendar.component(.year, from: date)
            
            let month = calendar.component(.month, from: date)
            let datee = calendar.component(.day, from: date)
            
            return "\(datee) \(getMonthName(monthOrder: String(month))) \(year)"
            
        } else {
           return "N/A"
        }
        
    }
    
    func parse() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
    }
    
    func getMonthName(monthOrder: String) -> String{
        switch monthOrder {
            case "1":
                return "January"
            case "2":
                return "February"
            case "3":
                return "March"
            case "4":
                return "April"
            case "5":
                return "Mei"
            case "6":
                return "June"
            case "7":
                return "July"
            case "8":
                return "August"
            case "9":
                return "September"
            case "10":
                return "October"
            case "11":
                return "November"
            case "12":
                return "December"
            default:
                return "-"
        }
    }
    
}
