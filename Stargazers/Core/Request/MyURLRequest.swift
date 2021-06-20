import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct MyURLRequest {
    let url: URL
    let method: HTTPMethod

    private init(url: URL,
                 method: HTTPMethod) {
        self.url = url
        self.method = method
    }

    static func get(url: URL) -> MyURLRequest {
        MyURLRequest(url: url,
                    method: .get)
    }
}

extension MyURLRequest {
    func with(component: String) -> MyURLRequest {
        MyURLRequest(url: url.appendingPathComponent(component),
                    method: self.method)
    }

    func appendQuery(name: String, value: String?) -> MyURLRequest {
        appendingQuery(item: URLQueryItem(name: name, value: value))
    }

    private func appendingQuery(item: URLQueryItem) -> MyURLRequest {
        guard let baseUrl = URLComponents(url: url)?.appendingQueryItem(item).url else {
            return MyURLRequest(url: self.url,
                               method: self.method)
        }
        return MyURLRequest(url: baseUrl,
                           method: self.method)
    }

    func build() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

private extension URLComponents {
    func appendingQueryItem(_ item: URLQueryItem) -> URLComponents {
        appendingQueryItems([item])
    }

    func appendingQueryItems(_ items: [URLQueryItem]) -> URLComponents {
        var components = self
        components.queryItems = components.queryItems ?? [URLQueryItem]()
        components.queryItems? += items

        return components
    }
}

private extension URLComponents {
    init?(url: URL) {
        self.init(url: url, resolvingAgainstBaseURL: false)
    }
}
