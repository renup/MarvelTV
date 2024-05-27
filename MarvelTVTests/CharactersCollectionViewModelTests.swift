//
//  CharactersCollectionViewModelTests.swift
//  MarvelTVTests
//
//  Created by Renu Punjabi on 5/25/24.
//

import XCTest
@testable import MarvelTV


final class CharactersCollectionViewModelTests: XCTestCase {
    var viewModel: CharactersCollectionViewModel!
    var mockService: MockCharactersRepository!
    
    override func setUpWithError() throws {
        mockService = MockCharactersRepository(endpoint: .characters, testCase: .success)
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
        let viewModel = CharactersCollectionViewModel(charactersRepository: MockCharactersRepository(endpoint: .characters, testCase: .failure))
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
    
    
    
    func test_pullCharacters_should_fail_with_badURL_response() async throws {
        let mockService = MockCharactersRepository(endpoint: .badCharacterEndpoint, testCase: .failure)
        let viewModel = CharactersCollectionViewModel(charactersRepository: mockService)
        
        viewModel.pullAllCharacters()
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "characters api call should fail with bad url response")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(viewModel.asyncState, .error)
            XCTAssertEqual(viewModel.error?.localizedDescription, "The operation couldn’t be completed. (NSURLErrorDomain error -1000.)")
            XCTAssertEqual(viewModel.characters.count, 0)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
    
    func test_pullCharacters_should_handle_decoding_error() async throws {
        let mockRepository = MockCharactersRepository(endpoint: .characters, testCase: .failure)
        let viewModel = CharactersCollectionViewModel(charactersRepository: mockRepository)
        
        viewModel.pullAllCharacters()
        XCTAssertEqual(viewModel.asyncState, .loading)
        
        let exp = XCTestExpectation(description: "characters api call should fail with decoding error")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertEqual(viewModel.asyncState, .error)
            XCTAssertEqual(viewModel.error?.localizedDescription, "The data couldn’t be read because it is missing.")
            XCTAssertEqual(viewModel.characters.count, 0)
            exp.fulfill()
        }
        
        await fulfillment(of: [exp], timeout: 5)
    }
}

class MockCharactersRepository: CharactersRepository {
    
    let requestBuilder = MockRequestBuilder()
    let endpoint: Endpoint
    let testCase: TestCase
    
    init(endpoint: Endpoint, testCase: TestCase) {
        self.endpoint = endpoint
        self.testCase = testCase
    }
    
    func fetchAllCharacters() async throws -> [MarvelTV.Character] {
        let networkTransport = MockNetworkTransport(endpoint: endpoint, testCase: testCase)
        let request = try await requestBuilder.buildRequest(endpoint: endpoint.rawValue, method: .get, parameters: [])
        let dataWrapper: DataWrapper<Character> = try await networkTransport.executeRequest(request, jsonDecoder: JSONDecoder())
        return dataWrapper.data.results
    }    
}

// NOTE: Other different ways of throwing different types of errors

//class MockCharactersRepositoryWithError: CharactersRepository {
//    
//    func fetchAllCharacters() async throws -> [MarvelTV.Character] {
//        throw URLError(.badServerResponse)
//    }
//}
//
//
//
//class MockInvalidDataNetworkTransport: NetworkTransport {
//    func executeRequest<T: Decodable>(_ request: URLRequest, jsonDecoder: JSONDecoder) async throws -> T {
//        throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid data"))
//    }
//}

// NOTE: And alternate ways of testing API calls which impliplicitly tests the middle layers (repository, network transport, models, etc)

//enum FileName: String {
//    case characters, comics, characters_failure, comics_failure
//}
//
//class MockCharactersRepository: CharactersRepository {
//    
//    let fileName: FileName
//    
//    init(fileName: FileName) {
//        self.fileName = fileName
//    }
//    
//    func fetchAllCharacters() async throws -> [MarvelTV.Character] {
//        guard let url = TestUtils.load(fileName) else { throw URLError(.badURL) }
//        let data = try! Data(contentsOf: url)
//        let result = try JSONDecoder().decode(DataWrapper<Character>.self, from: data)
//        return result.data.results
//    }
//}
