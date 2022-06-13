import Foundation
import UIKit

final class NotesListRouter: NotesListRoutingLogic, NotesListDataStore {
    var notes: [Note] = []

    weak var viewController: UIViewController?
    let dataStore: NotesListDataStore

    init(dataStore: NotesListDataStore) {
        self.dataStore = dataStore
    }

//    func passData(from note: Note, isChanged: Bool) {}
}

private extension NotesListRouter {
//    func passData(
//        source: NotesListDataStore,
//        destination: inout AddNoteDataStore
//    ) {
//        source = dataStore
//        destination = AddNoteDataStore()
//    }
}
