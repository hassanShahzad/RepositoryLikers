import Foundation

protocol MyServicePerformerProtocol {
    func stargazers(for user: User,
                    page: Int,
                    completion: @escaping ((Result<[MyStargazer], Error>) -> Void)) throws
}

struct MyServicePerformer {
    private let configuration: MyURLConfiguration

    init(configuration: MyURLConfiguration) {
        self.configuration = configuration
    }

    var baseUrl: URL? {
        URL(string: configuration.baseUrl)
    }

    func makeRequest<T: Decodable>(_ request: MyURLRequest,
                                     map: T.Type,
                                     completion: @escaping ((Result<T, Error>) -> Void)) throws {
        
        let urlRequest = request
            .build()

        configuration
            .service
            .performTask(with: urlRequest) { responseData, urlResponse, responseError in
                completion(self.makeDecode(response: responseData,
                                           urlResponse: urlResponse,
                                           map: map,
                                           error: responseError))
            }
    }

    private func makeDecode<T: Decodable>(response: Data?,
                                          urlResponse: URLResponse?,
                                          map: T.Type,
                                          error: Error?) -> (Result<T, Error>) {
        
        if let error = error { return (.failure(error)) }
        guard let jsonData = response else { return (.failure(MyServiceError.noData)) }
        
        let statusCode = urlResponse?.httpResponse?.statusCode ?? MyConstants.URL.statusCodeOk

        guard statusCode.inRange(MyConstants.URL.statusCodeOk ..< MyConstants.URL.statusCodemultipleChoice) else {
            return decode(response: jsonData,
                          map: MyError.self)
                .mapError(code: statusCode)
        }

        return decode(response: jsonData, map: map)
    }
    
    private func decode<T: Decodable>(response: Data,
                                          map: T.Type) -> (Result<T, Error>) {
        do {
            let decoded = try JSONDecoder().decode(map, from: response)
            return (.success(decoded))
        } catch { return (.failure(error)) }
    }
}

private extension URLResponse {
    var httpResponse: HTTPURLResponse? {
        self as? HTTPURLResponse
    }
}
