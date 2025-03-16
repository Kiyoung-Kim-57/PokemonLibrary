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
> 함수형 프로그래밍의 불변성을 적용하여 체이닝 방식으로 Request를 정의할 수 있도록 구현
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
> 체이닝 방식으로 가독성 향상
```swift
let request = HttpRequest(scheme: .https, method: .GET)
            .setURLPath(path: "\(path)")
            .addQueryItem("offset", "10")
            .addQueryItem("limit", "5")
```

## Response
### HttpResponse
> 제너릭 타입을 이용해 디코딩된 데이터 타입또는 원본 데이터를 상태 코드와 함께 묶어서 사용 
```swift
public struct HttpResponse<T: Decodable>: Responsable {
    public typealias ResponseType = T
    
    public var statusCode: Int
    public var response: ResponseType
}
```
# Network Manager
## Protocol
> 메서드 오버로딩으로 리턴 타입에 원본 데이터를 포함하는 것과 디코딩 타입을 포함하는 것을 구분
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

### DataSource Example
> RequestHandler를 이용해 선언형 스타일을 적용해 구현한 DataSource 구현 예시
```swift
public final class PLRemoteDataSource: PLReadableDataSource {
    public typealias Item = Data
    public typealias Condition = HttpRequest
    
    private let networkManager: NetworkManagerImpl
    private var baseRequest = HttpRequest(scheme: .https, method: .GET)
        .setURLPath(path: "pokeapi.co/api/v2/pokemon")
    
    public init(networkManager: NetworkManagerImpl) {
        self.networkManager = networkManager
    }
    
    public func readData(
        requestHandler: (HttpRequest) -> (HttpRequest) = { return $0 }
    ) async throws -> Data {
        let request = requestHandler(baseRequest)
        let httpResponse = try await networkManager.fetchData(request: request)
        
        return httpResponse.response
    }
}

//Test Code
func test_fetchPokemons_success() async throws {
    let data = try await remoteDatasource.readData { request in
        let request = request
            .addQueryItem("offset", "10")
            .addQueryItem("limit", "20")
        
        return request
    }
    
    let dto: PokemonListDTO = try data.toDTO(decoder: decoder)
    
    XCTAssertEqual(dto.results.count, 20, "Result: \(dto.results.description)")
}
```
