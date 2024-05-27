//
//  MockRequestBuilder.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/27/24.
//

import Foundation
@testable import MarvelTV

class MockRequestBuilder: RequestBuilder {
    
    func buildRequest(endpoint: String, method: MarvelTV.HTTPMethod, parameters: [URLQueryItem]?) async throws -> URLRequest {
        guard var urlComponents = URLComponents(string: Constants.baseUrl + endpoint) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = parameters
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
                
        return request
    }
}
