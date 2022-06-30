import Foundation
@testable import Note

final class ListInteractorMock: ListBusinessLogic {
    var interactorWasCalled = false

    func fetchNotes(_ request: ListModel.NotesList.Request) {
    }

    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request) {
    }

    func storeSelectedNote(_ index: Int?) {
    }
}
