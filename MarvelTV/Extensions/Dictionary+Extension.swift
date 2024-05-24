//
//  Dictionary+Extension.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    var asURLQueryItems: [URLQueryItem] {
        map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
    }
}
