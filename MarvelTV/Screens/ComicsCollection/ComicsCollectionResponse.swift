//
//  ComicsCollectionResponse.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/24/24.
//

import Foundation

struct Comic: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let issueNumber: Int
    let prices: [Price]
}

struct Price: Codable {
    let type: String
    let price: Double
}
