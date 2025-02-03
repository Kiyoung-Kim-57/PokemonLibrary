//
//  PLRemoteDataSource.swift
//  PLData
//
//  Created by 김기영 on 1/29/25.
//

import Foundation
import PokeNetwork

public final class PLRemoteDataSource: PLReadableDataSource {
    public typealias Item = Data
    public typealias Condition = HttpRequest
    
    private let networkManager: NetworkManagerImpl
    private var baseRequest = HttpRequest(scheme: .https, method: .GET)
        .setURLPath(path: "pokeapi.co/api/v2/pokemon")
    
    public init(networkManager: NetworkManagerImpl) {
        self.networkManager = networkManager
    }
    
    public func readData(
        requestHandler: @escaping (HttpRequest) -> (HttpRequest)
    ) async throws -> Data {
        let request = requestHandler(baseRequest)
        let httpResponse = try await networkManager.fetchData(request: request)
        
        return httpResponse.response
    }
}
