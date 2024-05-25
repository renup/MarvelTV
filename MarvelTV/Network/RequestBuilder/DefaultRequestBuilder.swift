//
//  DefaultRequestBuilder.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation
import CryptoKit
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "DefaultRequestBuilder", forDebugBuild: true)

class DefaultRequestBuilder: RequestBuilder {
    
    static let shared = DefaultRequestBuilder()
    
    func buildRequest(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [URLQueryItem]? = nil
    ) async throws -> URLRequest {
        guard var urlComponents = URLComponents(string: Constants.baseUrl + endpoint) else {
            throw URLError(.badURL)
        }
        
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(Constants.Keys.hasher)\(Constants.Keys.apiKey)")
        
        let defaultQueryItems: [URLQueryItem] = [
           "apikey" : Constants.Keys.apiKey,
           "ts" : timestamp,
           "hash" : hash
        ].asURLQueryItems
        
        var queryItems = defaultQueryItems
        
        if let parameters = parameters {
            queryItems.append(contentsOf: parameters)
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        logger.debug("request = \(request)")
        
        return request
    }
    
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
