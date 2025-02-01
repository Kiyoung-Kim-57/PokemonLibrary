//
//  NetworkTest.swift
//  NetworkTest
//
//  Created by 김기영 on 1/30/25.
//

import XCTest
@testable import PokeNetwork
@testable import PLData

final class NetworkTest: XCTestCase {
    let networkManager: NetworkManager = NetworkManager()
    
    override class func setUp() { }
    
    override class func tearDown() { }
    
    func test_리퀘스트_생성() throws {
        let request = try XCTUnwrap(
            HttpRequest(
                scheme: .https,
                method: .GET,
                path: "pokeapi.co/api/v2/pokemon"
            )
        )
    }
    
    func test_포켓몬API_호출() async throws {
        let request = try XCTUnwrap(
            HttpRequest(
                scheme: .https,
                method: .GET,
                path: "pokeapi.co/api/v2/pokemon"
            )
        )
        
        let data = try await networkManager.fetchData(request: request, type: PokemonListDTO.self)
        
        XCTAssertNotNil(data)
        
    }
    
    
    func test_쿼리아이템_추가() async throws {
        let request = try XCTUnwrap(
            HttpRequest(
                scheme: .https,
                method: .GET,
                path: "pokeapi.co/api/v2/pokemon"
            )
        )
            .addQueryItem("offset", "10")
            .addQueryItem("limit", "5")
        
        let data = try await networkManager.fetchData(request: request, type: PokemonListDTO.self)
        
        XCTAssertEqual(data.dto.results.count, 5, "Result: \(data.dto.results.description)")
    }
}
