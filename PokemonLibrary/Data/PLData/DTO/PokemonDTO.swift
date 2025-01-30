//
//  PokemonDTO.swift
//  PLData
//
//  Created by 김기영 on 1/30/25.
//

import Foundation

public struct PokemonDTO: Decodable {
    public let baseExperience: Int
    public let height: Int
    public let id: Int
    public let locationAreaEncounters: String
    public let name: String
    public let weight: Int

    public enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height
        case id
        case locationAreaEncounters = "location_area_encounters"
        case name
        case weight
    }
}
