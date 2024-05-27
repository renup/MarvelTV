//
//  MockNetworkTransport.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/27/24.
//

import Foundation
@testable import MarvelTV

enum TestCase {
    case success, failure
}

enum Endpoint: String {
    case characters, comics, badCharacterEndpoint, badComicEndpoint
    
    func loadMockData(for testCase: TestCase, endpoint: Endpoint) -> Data {
        switch testCase {
        case .success:
            let url = TestUtils.load(endpoint.rawValue)
            return try! Data(contentsOf: url!)
        case .failure:
            let url = TestUtils.load("\(endpoint.rawValue)_failure")
            return try! Data(contentsOf: url!)
        }
    }
}

class MockNetworkTransport: NetworkTransport {
    let endpoint: Endpoint
    let testCase: TestCase
    
    init(endpoint: Endpoint, testCase: TestCase) {
        self.endpoint = endpoint
        self.testCase = testCase
    }
    
    func fetchData(_ request: URLRequest) async throws -> Data {
//        let url = request.url!
//        let urlString = url.absoluteString
        if !endpoint.rawValue.hasPrefix("bad") {
            return endpoint.loadMockData(for: testCase, endpoint: endpoint)
        } else {
            throw URLError(.badURL)
        }
    }
    
    func decodeObject<T: Decodable>(_ data: Data, jsonDecoder: JSONDecoder = JSONDecoder()) throws -> T {
//        func logResponseBody() {
//            let errorDetails = String(data: data, encoding: .utf8) ?? ""
//            logger.debug("Failed Decoding Body: \(errorDetails)")
//        }
        
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
//            logResponseBody()
            throw error
        }
    }
    
    func executeRequest<T>(_ request: URLRequest, jsonDecoder: JSONDecoder) async throws -> T where T : Decodable {
        do {
            let data = try await fetchData(request)
            return try decodeObject(data, jsonDecoder: jsonDecoder)
        } catch {
            throw error
        }
    }
    
    
}
