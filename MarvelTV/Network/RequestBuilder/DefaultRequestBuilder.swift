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
    
    public func buildRequest(
        endpoint: String,
        method: HTTPMethod = .get,
        headers: [String: Any]? = nil,
        parameters: [URLQueryItem]? = nil
    ) async throws -> URLRequest {
        guard let url = URL(string: Constants.baseUrl+endpoint) else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(timestamp)\(Constants.Keys.hasher)\(Constants.Keys.apiKey)")
        
        let defaultParameters: [URLQueryItem] = [
            "apikey" : Constants.Keys.apiKey,
            "ts" : timestamp,
            "hash" : hash
        ].asURLQueryItems
        
        request.url?.append(queryItems: parameters ?? [])
        
        logger.debug("request = \(request)")
        
        return request
    }
    
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

