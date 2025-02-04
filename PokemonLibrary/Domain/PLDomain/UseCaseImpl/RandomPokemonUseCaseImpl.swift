//
//  RandomPokemonUseCaseImpl.swift
//  PokemonLibrary
//
//  Created by 김기영 on 2/5/25.
//

import Foundation

public final class RandomPokemonUseCaseImpl: RandomPokemonUseCase {
    private let repository: PokemonRepository
    
    public init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> PokemonListDTO {
        let randomOffset = Int.random(in: 0...1294)
        return try await repository.fetchPokemons(offset: randomOffset, limit: 10)
    }
}
