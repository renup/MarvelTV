//
//  ComicsCollectionViewModel.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/24/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "ComicsCollectionViewModel", forDebugBuild: true)

@Observable
class ComicsCollectionViewModel {
    
    var comics = [Comic]()
    var asyncState: AsyncState = .initial
    let comicsRepository: ComicsRespository
    
    init(comicsRepository: ComicsRespository = DefaultComicsRepository.shared) {
        self.comicsRepository = comicsRepository
    }
    
    func pullComics(for characterId: Int) {
        Task {
            do {
                let comics = try await comicsRepository.fetchComics(for: characterId)
                await MainActor.run {
                    self.comics = comics
                    asyncState = .loaded
                }
            } catch {
                await MainActor.run {
                    asyncState = .error
                    logger.debug("Error pulling comics: \(error)")
                }
            }
        }
    }
}
