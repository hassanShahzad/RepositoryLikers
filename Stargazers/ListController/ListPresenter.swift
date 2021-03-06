import Foundation

protocol ListPresenterProtocol: AnyObject {
    func stagazers(list: [MyStargazer])
    func on(error: Error)
    func fetch()
    func fetchNext()
}

class ListPresenter {
    private let view: ListViewProtocol?
    private let stargazersInteractor: GetStargazersInteractorProtocol
    private let user: User
    private var page: Int = 1

    init(view: ListViewProtocol?,
         stargazersInteractor: GetStargazersInteractorProtocol,
         user: User) {
        self.view = view
        self.stargazersInteractor = stargazersInteractor
        self.user = user
    }
}

extension ListPresenter: ListPresenterProtocol {
    func fetch() {
        stargazersInteractor.perform(user: user, page: self.page)
    }

    func fetchNext() {
        page += 1
        stargazersInteractor.perform(user: user, page: page)
    }

    func stagazers(list: [MyStargazer]) {
        view?.load(stargazers: list)
    }

    func on(error: Error) {
        view?.show(error: error)
    }
}
