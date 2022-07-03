import Foundation
@testable import Note

final class ListPresenterMock: ListPresentationLogic {
    var tryToPresentNotes = false
    var responseMock: ListModel.NotesList.Response?
    var responseNotesRemovingMock: ListModel.NotesRemoving.Response?

    var fetchResponse: (() -> Void)?
    var fetchResponseNotesRemoving: (() -> Void)?

    func presentNotes(_ response: ListModel.NotesList.Response) {
        tryToPresentNotes = true
        responseMock = response
        fetchResponse?()
    }

    func presentNotesRemoving(_ response: ListModel.NotesRemoving.Response) {
        tryToPresentNotes = true
        responseNotesRemovingMock = response
        fetchResponseNotesRemoving?()
    }
}
