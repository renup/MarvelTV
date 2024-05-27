//
//  String+Extension.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/27/24.
//

import Foundation

extension String {
    
    func formatDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d, yyyy"
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
