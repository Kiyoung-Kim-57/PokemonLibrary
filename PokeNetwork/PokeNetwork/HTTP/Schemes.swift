//
//  Schemes.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/27/25.
//

import Foundation

public enum Schemes: String {
    case http
    case https
    
    var string: String { rawValue }
}
