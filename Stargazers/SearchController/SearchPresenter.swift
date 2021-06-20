import Foundation
import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func search(user: User)
}

class SearchPresenter {
    private let view: SearchViewProtocol?
    private let wire: WireProtocol?

    init(view: SearchViewProtocol?,
         wire: WireProtocol?) {
        self.view = view
        self.wire = wire
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func search(user: User) {
        wire?.listController(user: user,
                             from: view)
    }
}
