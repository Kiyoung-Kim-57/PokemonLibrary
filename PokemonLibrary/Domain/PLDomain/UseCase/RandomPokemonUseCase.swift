//
//  RandomPokemonUseCase.swift
//  PokemonLibrary
//
//  Created by 김기영 on 2/5/25.
//

import Foundation

public protocol RandomPokemonUseCase {
    // TODO: RxSwift로 데이터 스트림 연결하기
    func execute() async throws -> PokemonSearchListDTO
}
