# HTTP
## Method
```swift
public enum HttpMethods: String {
    case GET
    case POST
    case PUT
    case DELETE
    
    var string: String { rawValue }
}
```
## Request
### HttpRequest
```swift
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

```
### Example
```swift
let request = HttpRequest(scheme: .https, method: .GET)
            .setURLPath(path: "\(path)")
            .addQueryItem("offset", "10")
            .addQueryItem("limit", "5")
```

## Response
### HttpResponse
```swift
public struct HttpResponse<T: Decodable>: Responsable {
    public typealias ResponseType = T
    
    public var statusCode: Int
    public var response: ResponseType
}
```
# Network Manager
## Protocol
```swift
public protocol NetworkManager {
    //Fetch Data & Decoding
    func fetchData<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T>
    //Fetch Data Only
    func fetchData(request: HttpRequest) async throws -> HttpResponse<Data>
}
```
## Implement
```swift
public final class NetworkManagerImpl: NetworkManager {
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    
    public func fetchData<T: Decodable>(request: HttpRequest, type: T.Type) async throws -> HttpResponse<T> {
        let (data, response) = try await urlSession.data(for: request.urlRequest)
        let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
        let dto: T = try data.toDTO(decoder: decoder)
        let httpResponse = HttpResponse(statusCode: statusCode, response: dto)
        
        return httpResponse
    }
    
    public func fetchData(request: HttpRequest) async throws -> HttpResponse<Data> {
        let (data, response) = try await urlSession.data(for: request.urlRequest)
        let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
        let httpResponse = HttpResponse(statusCode: statusCode, response: data)
        
        return httpResponse
    }
}
```

### Test Case
```swift
func test_add_query() async throws {
    let request = HttpRequest(scheme: .https, method: .GET)
        .setURLPath(path: "\(path)")
        .addQueryItem("offset", "10")
        .addQueryItem("limit", "5")
    
    let data = try await networkManager.fetchData(request: request, type: SampleDTO.self)
    
    XCTAssertEqual(data.response.results.count, 5, "Result: \(data.response.results.description)")
}
```
