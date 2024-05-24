//
//  CharactersResponse.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
//    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
}

struct MarvelResponse: Codable {
    let data: MarvelData
}

struct MarvelData: Codable {
    let results: [Character]
}
