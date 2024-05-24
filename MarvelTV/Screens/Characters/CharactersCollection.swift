//
//  CharactersCollection.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import SwiftUI

struct MarvelCharactersView: View {
    @State private var viewModel = CharactersCollectionViewModel()
    
    var body: some View {
        List(viewModel.characters, id: \.id) { character in
            Text(character.name)
        }
        .onAppear {
            viewModel.pullAllCharacters()
        }
    }
    
    
}


