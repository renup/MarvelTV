//
//  CharactersCollectionViewModelTests.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/25/24.
//

import XCTest
@testable import MarvelTV

enum FileName: String {
    case characters, comics, characters_failure, comics_failure
}

final class CharactersCollectionViewModelTests: XCTestCase {
    var viewModel: CharactersCollectionViewModel!
    var mockService: MockCharactersRepository!
    
    override func setUpWithError() throws {
        mockService = MockCharactersRepository(fileName: .characters)
        viewModel = CharactersCollectionViewModel(charactersRepository: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
    }

    func test_pullCharacters_should_succeed() async throws {
        viewModel.pullAllCharacters()
        
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "characters api call should succeed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(self.viewModel.asyncState, .loaded)
            XCTAssertEqual(self.viewModel.characters.first!.name, "3-D Man")
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
    
    func test_pullCharacters_should_fail() async throws {
        let viewModel = CharactersCollectionViewModel(charactersRepository: MockCharactersRepository(fileName: .characters_failure))
        viewModel.pullAllCharacters()
        
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "characters api call should fail")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(viewModel.asyncState, .error)
            XCTAssertEqual(viewModel.characters.count, 0)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
}

class MockCharactersRepository: CharactersRepository {
    
    let fileName: FileName
    
    init(fileName: FileName) {
        self.fileName = fileName
    }
    
    func fetchAllCharacters() async throws -> [MarvelTV.Character] {
        guard let url = TestUtils.load(fileName) else { throw URLError(.badURL) }
        let data = try! Data(contentsOf: url)
        let result = try JSONDecoder().decode(DataWrapper<Character>.self, from: data)
        return result.data.results
    }
    
    
}
