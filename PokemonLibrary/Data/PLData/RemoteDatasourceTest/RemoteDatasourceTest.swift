//
//  RemoteDatasourceTest.swift
//  RemoteDatasourceTest
//
//  Created by 김기영 on 2/3/25.
//

import XCTest
@testable import PLData
@testable import PokeNetwork

final class RemoteDatasourceTest: XCTestCase {
    let decoder = JSONDecoder()
    let networkManager = NetworkManagerImpl()
    lazy var remoteDatasource: PLRemoteDataSource = PLRemoteDataSource(networkManager: NetworkManagerImpl())
    
    override class func setUp() { }
    
    override class func tearDown() { }
    
    func test_fetchPokemons_success() async throws {
        let dto = try await remoteDatasource.readData(type: PokemonSearchListDTO.self) { request in
            let request = request
                .addQueryItem("offset", "10")
                .addQueryItem("limit", "20")
            
            return request
        }
        
        XCTAssertEqual(dto.results.count, 20, "Result: \(dto.results.description)")
    }
}
