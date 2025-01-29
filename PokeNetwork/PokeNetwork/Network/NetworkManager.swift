//
//  NetworkManager.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/28/25.
//

import Foundation

public final class NetworkManager {
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    
    public func fetchData<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T> {
        let (data, response) = try await urlSession.data(for: request.urlRequest)
        let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
        let dto: T = try data.toDTO(decoder: decoder)
        let httpResponse = HttpResponse(statusCode: statusCode, dto: dto)
        
        return httpResponse
    }
}


