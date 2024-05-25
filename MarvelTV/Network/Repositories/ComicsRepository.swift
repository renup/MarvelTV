//
//  ComicsRepository.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/24/24.
//

import Foundation

protocol ComicsRespository {
    func fetchComics(for characterId: Int) async throws -> [Comic]
}

class DefaultComicsRepository: ComicsRespository {
    static let shared = DefaultComicsRepository()
    
    let requestBuilder: RequestBuilder
    let networkTransport: NetworkTransport
    
    init(requestBuilder: RequestBuilder = DefaultRequestBuilder.shared, networkTransport: NetworkTransport = DefaultNetworkTransport.shared) {
        self.requestBuilder = requestBuilder
        self.networkTransport = networkTransport
    }
    
    func fetchComics(for characterId: Int) async throws -> [Comic] {
        let request = try await requestBuilder.buildRequest(endpoint: "comics", method: .get, parameters: ["characters" : characterId].asURLQueryItems)
        let dataWrapper: DataWrapper<Comic> = try await networkTransport.executeRequest(request, jsonDecoder: JSONDecoder())
        return dataWrapper.data.results
    }

}
