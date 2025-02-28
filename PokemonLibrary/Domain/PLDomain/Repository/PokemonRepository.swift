//
//  PokemonRepository.swift
//  PokemonLibrary
//
//  Created by 김기영 on 2/4/25.
//

import Foundation

public protocol PokemonRepository {
    // TODO: 필요 메서드 생성
    func fetchPokemons(offset: Int, limit: Int) async throws -> PokemonSearchListDTO
}
