import UIKit

final class NotesListRouter: NotesListRoutingLogic, NotesListDataStore {
    // MARK: - Properties
    weak var viewController: UIViewController?
    let dataStore: NotesListDataStore
    var notes: [Note] = []

    // MARK: - Initializers
    init(dataStore: NotesListDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - Methods
    func passDataTo(source: NotesListDataStore, destination: inout NoteDataStore) {
    }
}
