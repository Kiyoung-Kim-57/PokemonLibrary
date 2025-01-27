//
//  HTTPRequest.swift
//  PokeNetwork
//
//  Created by 김기영 on 1/27/25.
//

import Foundation

public struct HttpRequest {
    private let scheme: Schemes
    private let method: HttpMethods
    private let path: String
    private var httpBody: Data? = nil
    private var httpHeaders: [String: String] = [:]
    private var urlComponent: URLComponents
    
    public init?(scheme: Schemes, method: HttpMethods, path: String) {
        self.scheme = scheme
        self.method = method
        self.path = path
        
        guard let components = URLComponents(string: "\(scheme.rawValue)://\(path)")
        else { return nil }
        
        self.urlComponent = components
    }
}


// MARK: Requestable
extension HttpRequest: Requestable {
    public var urlRequest: URLRequest {
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = method.string
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = httpBody
        
        return request
    }
    
    public func addQueryItem(_ name: String, _ value: String) -> Self {
        var request = self
        request.urlComponent.queryItems?.append(URLQueryItem(name: name, value: value))
        return request
    }
    
    public mutating func changeQueryItemValue(_ name: String, _ value: String) {
        guard let index = self.urlComponent.queryItems?.firstIndex(where: { $0.name == name })
        else { return }
        
        self.urlComponent.queryItems?[index].value = value
    }
    
    public func addBody(body: Data) -> Self {
        var request = self
        request.httpBody = body
        return request
    }
    
    public func addHeader(key: String, value: String) -> Self {
        var request = self
        if let _ = request.httpHeaders[key] {
            request.httpHeaders[key] = value
        } else {
            request.httpHeaders.updateValue(value, forKey: key)
        }
        
        return request
    }
}
