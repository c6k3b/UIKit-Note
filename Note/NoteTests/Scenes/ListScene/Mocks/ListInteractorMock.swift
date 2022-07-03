import Foundation
@testable import Note

final class ListInteractorMock: ListBusinessLogic {
    var tryToFetchNotes = false
    var tryToPerformNotesRemoving = false
    var tryToStoreSelectedNote = false

    func fetchNotes(_ request: ListModel.NotesList.Request) {
        tryToFetchNotes = true
    }

    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request) {
        tryToPerformNotesRemoving = true
    }

    func storeSelectedNote(_ index: Int?) {
        tryToStoreSelectedNote = true
    }
}
