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

// MARK: Writable(Create & Update), Deletable(Delete)은 추후 구현 예정
