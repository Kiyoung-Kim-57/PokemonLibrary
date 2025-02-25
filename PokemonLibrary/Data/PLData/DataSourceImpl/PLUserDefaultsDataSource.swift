//
//  PLUserDefaultsDataSource.swift
//  PokemonLibrary
//
//  Created by 김기영 on 2/25/25.
//

import Foundation

final class PLUserDefaultsDataSource: PLReadableDataSource {
    public typealias Item = Data
    public typealias Condition = String
    
    private let standard = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let defaultKey = ""
    
    func readData(requestHandler: @escaping (String) -> (String)) async throws -> Data {
        let key = requestHandler(defaultKey)
        guard let data = standard.object(forKey: key) as? Data else { throw DataError.notFound }
        
        return data
    }
    
    func readData<T: Decodable>(
        type: T.Type,
        requestHandler: @escaping (String) -> (String)
    ) async throws -> T {
        let key = requestHandler(defaultKey)
        guard let data = standard.object(forKey: key) as? Data else { throw DataError.notFound }
        let decoded = try decoder.decode(T.self, from: data)
        
        return decoded
    }
}
