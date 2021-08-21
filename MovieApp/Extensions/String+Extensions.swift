//
//  String+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 8/21/21.
//

import Foundation

extension String {
    
    func asDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: self)
    }
    
}
