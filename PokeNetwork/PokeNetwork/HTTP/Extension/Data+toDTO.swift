//
//  Data+toDTO.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/28/25.
//

import Foundation

extension Data {
    public func toDTO<T: Decodable>(decoder: JSONDecoder) throws -> T {
        let dto = try decoder.decode(T.self, from: self)
        return dto
    }
}
