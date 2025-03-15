import XCTest
@testable import PokeNetwork
@testable import PLData

final class PokeNetworkTests: XCTestCase {
    let networkManager: NetworkManagerImpl = NetworkManagerImpl()
    
    override class func setUp() { }
    
    override class func tearDown() { }
    
    func test_포켓몬API_호출() async throws {
        let request = HttpRequest(scheme: .https, method: .GET)
            .setURLPath(path: "pokeapi.co/api/v2/pokemon")
        
        let data = try await networkManager.fetchData(request: request, type: PokemonSearchListDTO.self)
        
        XCTAssertNotNil(data)
    }
    
    
    func test_쿼리아이템_추가() async throws {
        let request = HttpRequest(scheme: .https, method: .GET)
            .setURLPath(path: "pokeapi.co/api/v2/pokemon")
            .addQueryItem("offset", "10")
            .addQueryItem("limit", "5")
        
        let data = try await networkManager.fetchData(request: request, type: PokemonSearchListDTO.self)
        
        XCTAssertEqual(data.response.results.count, 5, "Result: \(data.response.results.description)")
    }
}
