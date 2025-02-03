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
    public typealias Condition = String
    
    private let networkManager: NetworkManager
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func readData(_ condition: String) async throws -> Data {
        let httpRequest = HttpRequest(scheme: .https, method: .GET)
        
        // MARK: 구현 미완
        
        return Data()
    }
}
