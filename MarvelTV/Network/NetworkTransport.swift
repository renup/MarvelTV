//
//  NetworkTransport.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "MarvelTV", category: "DefaultNetworkTransport", forDebugBuild: true)


protocol NetworkTransport {
    func executeRequest<T: Decodable>(_ request: URLRequest, jsonDecoder: JSONDecoder) async throws -> T
}

class DefaultNetworkTransport: NetworkTransport {
    
    func fetchData(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            logger.debug("Error bad response data: \(String(data: data, encoding: .utf8 ) ?? "(no data)"), response: \(String(describing: response))")
            throw URLError(.badServerResponse)
        }
        
        return data
    }
    
    func decodeObject<T: Decodable>(_ data: Data, jsonDecoder: JSONDecoder = JSONDecoder()) throws -> T {
        func logResponseBody() {
            let errorDetails = String(data: data, encoding: .utf8) ?? ""
            logger.debug("Failed Decoding Body: \(errorDetails)")
        }
        
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            logResponseBody()
            throw error
        }
    }
    
    func executeRequest<T: Decodable>(_ request: URLRequest, jsonDecoder: JSONDecoder = JSONDecoder()) async throws -> T {
            do {
                let data = try await fetchData(request)
                return try decodeObject(data, jsonDecoder: jsonDecoder)
            } catch {
                throw error // Rethrow the error
            }
        }
    
}
