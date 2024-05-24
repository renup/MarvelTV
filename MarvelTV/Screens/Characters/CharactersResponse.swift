//
//  CharactersResponse.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case thumbnail
    }
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case `extension` = "extension"
    }
    
    var url: URL? {
        let urlString = "\(path).\(`extension`)"
        return URL(string: urlString)
    }
}

struct MarvelResponse: Codable {
    let data: MarvelData
}

struct MarvelData: Codable {
    let results: [Character]
}
