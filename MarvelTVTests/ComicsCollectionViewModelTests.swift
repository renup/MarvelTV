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
        mockService = MockComicsRepository(endpoint: .comics, testCase: .success, parameters: ["characters" : 1234])
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
    
    func test_pullComics_should_fail_with_decoding_error() async throws {
        let viewModel = ComicsCollectionViewModel(comicsRepository: MockComicsRepository(endpoint: .comics, testCase: .failure, parameters: [:]))
        viewModel.pullComics(for: 1234)
        
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "comics api call should fail")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(viewModel.asyncState, .error)
            XCTAssertEqual(viewModel.error?.localizedDescription, "The data couldn’t be read because it is missing.")
            XCTAssertEqual(viewModel.comics.count, 0)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
    
    func test_pullComics_should_fail_with_badURL_response() async throws {
        let mockService = MockComicsRepository(endpoint: .badComicEndpoint, testCase: .failure, parameters: [:])
        let viewModel = ComicsCollectionViewModel(comicsRepository: mockService)
        
        viewModel.pullComics(for: 123)
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "comics api call should fail with bad url response")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(viewModel.asyncState, .error)
            XCTAssertEqual(viewModel.error?.localizedDescription, "The operation couldn’t be completed. (NSURLErrorDomain error -1000.)")
            XCTAssertEqual(viewModel.comics.count, 0)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
    
}

class MockComicsRepository: ComicsRespository {
    let requestBuilder = MockRequestBuilder()
    let endpoint: Endpoint
    let testCase: TestCase
    var parameters = [String : Any]()
    
    init(endpoint: Endpoint, testCase: TestCase, parameters: [String : Any]) {
        self.endpoint = endpoint
        self.testCase = testCase
        self.parameters = parameters
    }
    
    func fetchComics(for characterId: Int) async throws -> [MarvelTV.Comic] {
        let networkTransport = MockNetworkTransport(endpoint: endpoint, testCase: testCase)
        let request = try await requestBuilder.buildRequest(endpoint: endpoint.rawValue, method: .get, parameters: parameters.asURLQueryItems)
        let dataWrapper: DataWrapper<Comic> = try await networkTransport.executeRequest(request, jsonDecoder: JSONDecoder())
        return dataWrapper.data.results
    }
}
