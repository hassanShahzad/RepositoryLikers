import Foundation
import UIKit

struct ListRouter {
    private let wire: WireProtocol
    private let configuration: MyURLConfiguration
    private let user: User

    init(wire: WireProtocol,
         configuration: MyURLConfiguration,
         user: User) {
        self.wire = wire
        self.configuration = configuration
        self.user = user
    }
}

extension ListRouter: PresentationProtocol {
    func load() -> UIViewController {
        let view = UIStoryboard(name: "Main",
                            bundle: nil)
                   .instantiateViewController(withIdentifier: "listViewController") as? ListViewController

        let imageDownloader = MyImageDownloader(service: configuration.service, cache: MyCacheService())
        let service = MyServicePerformer(configuration: configuration)
        let interactor = GetStargazersInteractor(service: service)
        let presenter = ListPresenter(view: view,
                                      stargazersInteractor: interactor,
                                      user: user)

        interactor.presenter = presenter
        view?.presenter = presenter
        view?.downloader = imageDownloader

        return view ?? UIViewController()
    }
}
