//
//  CharactersCollection.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import SwiftUI

struct MarvelCharactersView: View {
    @State private var characters: [Character] = []
    
    private let publicKey = "139085d9053f946275efce81067b8ad2"
    private let privateKey = "0c2b0bb995abceed3975e8144b033d4e8c92e547"
    
    var body: some View {
        List(characters, id: \.id) { character in
            Text(character.name)
        }
        .task {
            await fetchCharacters()
        }
    }
    
    
}


