import Foundation

protocol MyURLServiceProtocol {
    func performTask(with request: URLRequest,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func performTask(with url: URL,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

struct MyURLService {
    private let session: MyURLSessionProtocol
    private let dispatcher: Dispatcher

    init(session: MyURLSessionProtocol = MyURLSession(),
         dispatcher: Dispatcher = DefaultDispatcher()) {
        self.session = session
        self.dispatcher = dispatcher
    }
}

extension MyURLService: MyURLServiceProtocol {
    func performTask(with request: URLRequest,
                            completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.dataTask(with: request) { responseData, urlResponse, responseError in
            self.dispatcher.dispatch {
                completion(responseData, urlResponse, responseError)
            }
        }
    }

    func performTask(with url: URL,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.dataTask(with: url) { responseData, urlResponse, responseError in
            self.dispatcher.dispatch {
                completion(responseData, urlResponse, responseError)
            }
        }
    }
}
