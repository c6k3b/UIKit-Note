import Foundation
@testable import Note

final class ListViewControllerMock: ListDisplayLogic {
    var displayNotesCalled: (Bool, ListModel.NotesList.ViewModel)!
    var displayNotesRemovingCalled: (Bool, ListModel.NotesRemoving.ViewModel)!

    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel) {
        displayNotesCalled = (true, viewModel)
    }

    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel) {
        displayNotesRemovingCalled = (true, viewModel)
    }
}
