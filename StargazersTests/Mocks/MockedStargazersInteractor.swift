import Foundation
@testable import Stargazers

class MockedStargazersInteractor: GetStargazersInteractorProtocol {
    var counterPerform: Int = 0
    var performrHandler: ((User, Int) -> Void)?

    public init() {}

    func perform(user: User, page: Int) {
        counterPerform += 1
        if let performrHandler = performrHandler {
            return performrHandler(user, page)
        }
    }
}
