//
//  CharactersCollectionViewModel.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "CharactersCollectionViewModel", forDebugBuild: true)

@Observable
class CharactersCollectionViewModel {
    
    let charactersRepository: CharactersRepository
    var asyncState: AsyncState = .initial
    
    init(charactersRepository: CharactersRepository = DefaultCharactersRepository()) {
        self.charactersRepository = charactersRepository
    }
    
    func pullAllCharacters() {
        asyncState = .loading
        Task {
            do {
                let characters = try await charactersRepository.fetchAllCharacters()
                asyncState = .loaded
            } catch {
                asyncState = .error
                logger.debug("\(error)")
            }
        }
    }
    
}
