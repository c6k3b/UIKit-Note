import Foundation
@testable import Note

final class ListViewControllerMock: ListDisplayLogic {
    var viewControllerWasCalled = false

    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel) {
        viewControllerWasCalled = true
    }

    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel) {
        viewControllerWasCalled = true
    }
}
