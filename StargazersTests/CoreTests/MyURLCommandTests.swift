import XCTest
@testable import Stargazers

class MyURLCommandTests: XCTestCase {
    override func setUp() {}

    func configure(_ session: MyURLSessionProtocol) -> MyURLConfiguration {
        let service = MyURLService(session: session,
                                   dispatcher: SyncDispatcher())
        return MyURLConfiguration(service: service,
                                  baseUrl: "https://api.github.com")
    }
}

func == (lhs: MyServiceError, rhs: MyServiceError) -> Bool {
    switch (lhs, rhs) {
    case (let .couldNotCreate(url), let .couldNotCreate(url2)):
        return url == url2
    case (.noData, .noData):
        return true
    default:
        return false
    }
}
