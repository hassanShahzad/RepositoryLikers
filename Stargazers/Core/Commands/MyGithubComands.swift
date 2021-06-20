import Foundation

struct User {
    let name: String
    let repo: String
}

extension MyServicePerformer: MyServicePerformerProtocol {
    func stargazers(for user: User,
                    page: Int,
                    completion: @escaping ((Result<[MyStargazer], Error>) -> Void)) throws {

        guard let url = baseUrl else {
            completion(.failure(MyServiceError.couldNotCreate(url: baseUrl?.absoluteString)))
            return
        }

        let request = { () -> MyURLRequest in
            MyURLRequest
                .get(url: url)
                .with(component: MyConstants.URL.Component.repos)
                .with(component: user.name)
                .with(component: user.repo)
                .with(component: MyConstants.URL.Component.stargazers)
                .appendQuery(name: MyConstants.URL.Query.perPage, value: "20")
                .appendQuery(name: MyConstants.URL.Query.page, value: page.stringValue)
        }

        try makeRequest(request(),
                        map: [MyStargazer].self,
                        completion: completion)
    }
}

private extension Int {
    var stringValue: String {
        String(self)
    }
}
