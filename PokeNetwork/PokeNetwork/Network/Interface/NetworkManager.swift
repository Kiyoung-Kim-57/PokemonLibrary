//
//  NetworkManagerInterface.swift
//  PokeNetwork
//
//  Created by 김기영 on 2/3/25.
//

import Foundation

public protocol NetworkManager {
    func fetchData<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T>
    func fetchData(request: HttpRequest) async throws -> HttpResponse<Data>
}
