//
//  PLDataSource.swift
//  PLData
//
//  Created by 김기영 on 1/29/25.
//

import Foundation

public protocol PLDataSource {
    associatedtype Item
    associatedtype Condition
}

public protocol PLReadableDataSource: PLDataSource {
    func readData(requestHandler: @escaping (Condition) -> (Condition)) async throws -> Item
    
    func readData<T: Decodable>(
        type: T.Type,
        requestHandler: @escaping (Condition) -> (Condition)
    ) async throws -> T
}

public protocol PLWritableDataSource: PLDataSource {
    // MARK: 쓰기 성공 여부를 Bool값으로 return, 이미 있다면 update 없다면 create
    @discardableResult
    func writeData(
        _ item: Item,
        requestHandler: @escaping (Condition) -> (Condition)
    ) async throws -> Bool
}

public protocol PLDeletableDataSource: PLDataSource {
    @discardableResult
    func deleteData(
        requestHandler: @escaping (Condition) -> (Condition)
    ) async throws -> Bool
}
