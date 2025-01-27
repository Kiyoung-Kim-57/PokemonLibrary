//
//  HttpMethods.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/27/25.
//

import Foundation

public enum HttpMethods: String {
    case GET
    case POST
    case PUT
    case DELETE
    
    var string: String { rawValue }
}
