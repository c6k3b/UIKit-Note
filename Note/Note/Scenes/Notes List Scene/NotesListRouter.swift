import UIKit

final class NotesListRouter: NotesListRoutingLogic, NotesListDataStore {
    var notes: [Note]?

    weak var viewController: UIViewController?
    let dataStore: NotesListDataStore

    init(dataStore: NotesListDataStore) {
        self.dataStore = dataStore
    }
}

private extension NotesListRouter {
//    func passDataTo_() {
//        source: CounterDataStore,
//        destination: inout SomewhereDataStore
//    ) {
//    }
}
