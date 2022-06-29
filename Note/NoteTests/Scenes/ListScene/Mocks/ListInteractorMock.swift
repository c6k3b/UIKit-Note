import Foundation
@testable import Note

final class ListInteractorMock: ListBusinessLogic {
    var interactorWasCalled = false

    func fetchNotes(_ request: ListModel.NotesList.Request) {
    }

    func update() {
    }

    func storeSelectedNote(_ index: Int?) {
    }

    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request) {
    }
}
