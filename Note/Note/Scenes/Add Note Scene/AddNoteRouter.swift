import UIKit

final class AddNoteRouter: AddNoteRoutingLogic, AddNoteDataStore {
    weak var viewController: UIViewController?
    let dataStore: AddNoteDataStore

    init(dataStore: AddNoteDataStore) {
        self.dataStore = dataStore
    }
}

private extension AddNoteRouter {
//    func passDataTo_() {
//        source: CounterDataStore,
//        destination: inout SomewhereDataStore
//    ) {
//    }
}
