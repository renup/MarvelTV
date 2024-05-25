//
//  PlaceholderProvider.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/24/24.
//

import Foundation
import SwiftUI

struct PlaceholderProvider {
    let colorArray: [Color] = [Color.green, Color.blue, Color.pink, Color.orange, Color.red, Color.brown].map { color in
        color.opacity(0.5)
    }
    
    func getRandomShinyColor() -> Color {
        return colorArray.randomElement() ?? .gray
    }
}
