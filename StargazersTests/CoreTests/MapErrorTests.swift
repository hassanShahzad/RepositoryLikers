import XCTest
@testable import Stargazers

class MapErrorTests: XCTestCase {
    func testMapError() {
        guard let data = JSONMock.loadJson(fromResource: "valid_error") else {
            XCTFail("JSON data error!")
            return
        }

        let url = URL(string: "https://api.github.com")!
        let response = HTTPURLResponse(url: url,
                                       statusCode: 401,
                                       httpVersion: "1.0",
                                       headerFields: [:])
        
        let session = MockedSession.simulate(failure: response, data: data) { _ in }

        let service = MyURLService(session: session,
                                   dispatcher: SyncDispatcher())
        let config =  MyURLConfiguration(service: service,
                                        baseUrl: "https://api.github.com")
        
        do {
            try MyServicePerformer(configuration: config)
                .stargazers(for: User(name: "", repo: ""), page: 0) { result in
                    switch result {
                    case .success:
                        XCTFail("Should be fail! Got success.")
                    case .failure(let error):
                        XCTAssertEqual(error.localizedDescription, "Not Found")
                    }
                }
        } catch { XCTFail("Unexpected error \(error)!") }
    }
}
