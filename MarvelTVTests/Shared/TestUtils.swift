//
//  TestUtils.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/25/24.
//

import Foundation

class TestUtils {
    static func load(_ fileName: FileName) -> URL? {
        return Bundle(for: TestUtils.self).url(forResource: fileName.rawValue, withExtension: "json")
    }
}
