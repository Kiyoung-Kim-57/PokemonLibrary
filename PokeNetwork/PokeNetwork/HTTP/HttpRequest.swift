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
    private var httpBody: Data? = nil
    private var httpHeaders: [String: String] = [:]
    private var urlComponent: URLComponents
    
    public init(scheme: Schemes, method: HttpMethods) {
        self.scheme = scheme
        self.method = method
        self.urlComponent = URLComponents()
        self.urlComponent.scheme = scheme.string
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
    
    public func setURLPath(path: String) -> Self {
        var request = self
        request.urlComponent.path = path
        return request
    }
    
    public func addQueryItem(_ name: String, _ value: String) -> Self {
        var request = self
        if request.urlComponent.queryItems == nil {
            request.urlComponent.queryItems = []
        }
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
        request.httpHeaders[key] = value
        return request
    }
}
