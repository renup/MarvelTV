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
    var characters = [Character]()
    var error: Error?
    
    init(charactersRepository: CharactersRepository = DefaultCharactersRepository.shared) {
        self.charactersRepository = charactersRepository
    }
    
    func pullAllCharacters() {
        asyncState = .loading
        Task {
            do {
                let characters = try await charactersRepository.fetchAllCharacters()
                await MainActor.run {
                    self.characters = characters
                    asyncState = .loaded
                }
            } catch {
                await MainActor.run {
                    asyncState = .error
                    self.error = error // Added for unit testing, but can also be used to recognise specific errors and display custom errors.
                    logger.debug("Error pulling characters: \(error.localizedDescription)")
                    logger.debug("Error pulling characters: \(error)")

                }
            }
        }
    }
    
}
