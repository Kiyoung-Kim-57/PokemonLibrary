//
//  NetworkError.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/29/25.
//

import Foundation

public enum NetworkError: Error {
    case requestObjectError
    
    public var description: String {
        switch self {
        case .requestObjectError: "Failed to initialize HttpRequest"
        }
    }
}
