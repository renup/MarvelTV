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
    
    static let shared = DefaultCharactersRepository()
    
    let requestBuilder: RequestBuilder
    let networkTransport: NetworkTransport
    
    init(requestBuilder: RequestBuilder = DefaultRequestBuilder.shared, networkTransport: NetworkTransport = DefaultNetworkTransport.shared) {
        self.requestBuilder = requestBuilder
        self.networkTransport = networkTransport
    }
    
    func fetchAllCharacters() async throws -> [Character] {
        let request = try await requestBuilder.buildRequest(endpoint: "characters", method: .get, parameters: [])
        let dataWrapper: DataWrapper<Character> = try await networkTransport.executeRequest(request, jsonDecoder: JSONDecoder())
        return dataWrapper.data.results
    }
    
}
