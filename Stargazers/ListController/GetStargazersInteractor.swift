import Foundation

protocol GetStargazersInteractorProtocol {
    func perform(user: User, page: Int)
}

class GetStargazersInteractor: GetStargazersInteractorProtocol {
    private let service: MyServicePerformerProtocol
    weak var presenter: ListPresenterProtocol?

    init(service: MyServicePerformerProtocol) {
        self.service = service
    }

    func perform(user: User, page: Int) {
        performTry({
            try service.stargazers(for: user,
                                   page: page) { result in
                switch result {
                case .success(let response):
                    self.presenter?.stagazers(list: response)
                case .failure(let error):
                    self.presenter?.on(error: error)
                }
            }
        }, fallback: { self.presenter?.on(error: $0) })
    }
}
