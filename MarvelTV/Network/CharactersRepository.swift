//
//  CharactersRepository.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation
import CryptoKit

protocol CharactersRepository {
    func fetchAllCharacters() async throws -> [Character]
}

class DefaultCharactersRepository: CharactersRepository {
    
    let requestBuilder: RequestBuilder
    
    init(requestBuilder: RequestBuilder = DefaultRequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
    
    func fetchAllCharacters() async throws -> [Character] {
//            let timestamp = String(Date().timeIntervalSince1970)
//        let hash = MD5(string: "\(timestamp)\(Constants.Keys.hasher)\(Constants.Keys.apiKey)")
            
//            let urlString = "https://gateway.marvel.com/v1/public/characters?apikey=\(publicKey)&ts=\(timestamp)&hash=\(hash)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let marvelResponse = try JSONDecoder().decode(MarvelResponse.self, from: data)
                characters = marvelResponse.data.results
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
}
