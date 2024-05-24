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
    let networkTransport: NetworkTransport
    
    init(requestBuilder: RequestBuilder = DefaultRequestBuilder(), networkTransport: NetworkTransport = DefaultNetworkTransport()) {
        self.requestBuilder = requestBuilder
        self.networkTransport = networkTransport
    }
    
    
    func fetchAllCharacters() async throws -> [Character] {
//            let timestamp = String(Date().timeIntervalSince1970)
//        let hash = MD5(string: "\(timestamp)\(Constants.Keys.hasher)\(Constants.Keys.apiKey)")
            
//            let urlString = "https://gateway.marvel.com/v1/public/characters?apikey=\(publicKey)&ts=\(timestamp)&hash=\(hash)"
            
        let request = try await requestBuilder.buildRequest(endpoint: "characters", method: .get, parameters: [])
        
        let result: MarvelResponse = try await networkTransport.executeRequest(request, jsonDecoder: JSONDecoder())
        
        return result.data.results
        
        }
}
