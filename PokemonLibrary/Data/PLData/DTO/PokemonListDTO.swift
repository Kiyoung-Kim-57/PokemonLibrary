//
//  PokemonListDTO.swift
//  PLData
//
//  Created by 김기영 on 1/30/25.
//

import Foundation

public struct PokemonListDTO: Decodable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [PokemonSearchResultDTO]
}
