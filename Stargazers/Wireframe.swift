import Foundation
import UIKit

protocol PresentationProtocol {
    func load() -> UIViewController
}

protocol WireProtocol {
    func searchController() -> UINavigationController
    func listController(user: User, from sender: Any?)
}

struct Wireframe: WireProtocol {
    private let configuration: MyURLConfiguration

    init(configuration: MyURLConfiguration) {
        self.configuration = configuration
    }

    func searchController() -> UINavigationController {
        UINavigationController(rootViewController: SearchRouter(wire: self).load())
    }

    func listController(user: User, from sender: Any?) {
        let list = ListRouter(wire: self,
                   configuration: configuration,
                   user: user).load()
        (sender as? UIViewController)?
            .navigationController?
            .pushViewController(list, animated: false)
    }
}
