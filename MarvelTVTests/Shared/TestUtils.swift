//
//  TestUtils.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/25/24.
//

import Foundation

class TestUtils {
    static func load(_ fileName: String) -> URL? {
        return Bundle(for: TestUtils.self).url(forResource: fileName, withExtension: "json")
    }
}
