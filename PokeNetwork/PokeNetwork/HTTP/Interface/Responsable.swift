//
//  Responsable.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/28/25.
//

import Foundation

public protocol Responsable {
    associatedtype DTOType: Decodable
    
    var statusCode: Int { get set }
    var dto: DTOType { get set }
}
