//
//  NetworkManager.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/28/25.
//

import Foundation

public final class NetworkManager {
    let urlSession = URLSession.shared
    
    public func fetchData(request: HttpRequest) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.urlRequest)

        return data
    }
}


