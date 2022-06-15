import UIKit

final class NoteRouter: NoteRoutingLogic, NoteDataStore {
    weak var viewController: UIViewController?
    let dataStore: NoteDataStore

    init(dataStore: NoteDataStore) {
        self.dataStore = dataStore
    }
}

private extension NoteRouter {
//    func passDataTo_() {
//        source: CounterDataStore,
//        destination: inout SomewhereDataStore
//    ) {
//    }
}
