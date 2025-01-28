//
//  HttpResponse.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/28/25.
//

import Foundation

public struct HttpResponse<T: Decodable> {
    public let statusCode: Int
    public let dto: T
}
