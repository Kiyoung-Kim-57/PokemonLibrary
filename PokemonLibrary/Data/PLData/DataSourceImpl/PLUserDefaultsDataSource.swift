//
//  PLUserDefaultsDataSource.swift
//  PokemonLibrary
//
//  Created by 김기영 on 2/25/25.
//

import Foundation

final class PLUserDefaultsDataSource: PLDataSourceProtocol {
    public typealias Item = Data
    public typealias Condition = String
    
    private let standard = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let defaultKey = "UserInfo"
    
    /// ReqeustHandler는 UserDefaults의 Key를 탈출 클로저로 따로 수정할 수 있게 합니다
    func readData(
        requestHandler: (String) -> (String) = { return $0 }
    ) async throws -> Data {
        let key = requestHandler(defaultKey)
        
        return try await withCheckedThrowingContinuation { continuation in
            if let data = standard.data(forKey: key) {
                continuation.resume(returning: data)
            } else {
                continuation.resume(throwing: DataError.notFound)
            }
        }
    }
    
    func readData<T: Decodable>(
        type: T.Type,
        requestHandler: (String) -> (String) = { return $0 }
    ) async throws -> T {
        let key = requestHandler(defaultKey)
        
        return try await withCheckedThrowingContinuation { continuation in
            if let data = standard.data(forKey: key),
               let decoded = try? decoder.decode(T.self, from: data) {
                continuation.resume(returning: decoded)
            } else {
                continuation.resume(throwing: DataError.notFound)
            }
        }
    }
    
    func writeData(
        _ item: Data,
        requestHandler: (String) -> (String) = { return $0 }
    ) async throws -> Bool {
        let key = requestHandler(defaultKey)
        
        return await withCheckedContinuation { continuation in
            self.standard.set(item, forKey: key)
            continuation.resume(returning: true)
        }
    }
    
    func deleteData(
        requestHandler: (String) -> (String) = { return $0 }
    ) async throws -> Bool {
        let key = requestHandler(defaultKey)
        
        return await withCheckedContinuation { continuation in
            if standard.object(forKey: key) != nil {
                standard.removeObject(forKey: key)
                continuation.resume(returning: true)
            } else {
                continuation.resume(returning: false)
            }
        }
    }
}
