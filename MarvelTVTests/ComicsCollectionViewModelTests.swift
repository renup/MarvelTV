//
//  ComicsCollectionViewModelTests.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/25/24.
//

import XCTest
@testable import MarvelTV

final class ComicsCollectionViewModelTests: XCTestCase {

    var viewModel: ComicsCollectionViewModel!
    var mockService: MockComicsRepository!
    
    override func setUpWithError() throws {
        mockService = MockComicsRepository(fileName: .comics)
        viewModel = ComicsCollectionViewModel(comicsRepository: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
    }

    func test_pullComics_should_succeed() async throws {
        viewModel.pullComics(for: 1234)
        
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "comics api call should succeed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(self.viewModel.asyncState, .loaded)
            XCTAssertEqual(self.viewModel.comics.first!.title, "Warlock: Rebirth (Trade Paperback)")
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
    
    func test_pullComics_should_fail() async throws {
        let viewModel = ComicsCollectionViewModel(comicsRepository: MockComicsRepository(fileName: .comics_failure))
        viewModel.pullComics(for: 1234)
        
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "comics api call should fail")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(viewModel.asyncState, .error)
            XCTAssertEqual(viewModel.comics.count, 0)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
}

class MockComicsRepository: ComicsRespository {
    let fileName: FileName
    
    init(fileName: FileName) {
        self.fileName = fileName
    }
    
    func fetchComics(for characterId: Int) async throws -> [MarvelTV.Comic] {
        guard let url = TestUtils.load(fileName) else { throw URLError(.badURL) }
        let data = try! Data(contentsOf: url)
        let result = try JSONDecoder().decode(DataWrapper<Comic>.self, from: data)
        return result.data.results
    }
}
