//
//  HttpResponse.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/28/25.
//

import Foundation

public struct HttpResponse<T: Decodable>: Responsable {
    public typealias ResponseType = T
    
    public var statusCode: Int
    public var response: ResponseType
}
