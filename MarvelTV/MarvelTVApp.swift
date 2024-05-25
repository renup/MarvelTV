//
//  MarvelTVApp.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import SwiftUI

@main
struct MarvelTVApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersCollectionView()
                .background(Theme.backgroundColor)
                .foregroundColor(Theme.foregroundColor)
                .accentColor(Theme.accentColor)
        }
    }
}


struct Theme {
    static let backgroundColor = Color.black
    static let foregroundColor = Color.white
    static let accentColor = Color.blue
}

