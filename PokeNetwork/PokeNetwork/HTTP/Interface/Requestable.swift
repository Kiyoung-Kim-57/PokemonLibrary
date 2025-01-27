//
//  Requestable.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/27/25.
//

import Foundation

public protocol Requestable {
    var urlRequest: URLRequest { get }
    
    func addQueryItem(_ name: String, _ value: String) -> Self
    func addBody(body: Data) -> Self
    func addHeader(key: String, value: String) -> Self
    mutating func changeQueryItemValue(_ name: String, _ value: String)
}
