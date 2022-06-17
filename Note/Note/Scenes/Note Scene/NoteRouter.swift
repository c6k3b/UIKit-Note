import UIKit

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
    // MARK: - Props
    weak var viewController: UIViewController?
    var dataStore: NoteDataStore

    // MARK: - Initializers
    init(dataStore: NoteDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - Routing
    func route() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
