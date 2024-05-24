//
//  RequestBuilder.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestBuilder: AnyObject {
    func buildRequest(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: Any]?,
        parameters: [URLQueryItem]?
    ) async throws -> URLRequest
}
