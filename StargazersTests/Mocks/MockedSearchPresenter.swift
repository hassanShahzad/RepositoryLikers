import Foundation
@testable import Stargazers

class MockedSearchPresenter: SearchPresenterProtocol {
    var counterSearchUser: Int = 0
    var searchUserHandler: ((User) -> Void)?

    public init() {}

    func search(user: User) {
        counterSearchUser += 1
        if let searchUserHandler = searchUserHandler {
            return searchUserHandler(user)
        }
    }
}
