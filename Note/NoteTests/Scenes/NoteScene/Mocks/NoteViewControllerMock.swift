import Foundation
@testable import Note

final class NoteViewControllerMock: NoteDisplayLogic {
    var displayNoteCalled: (Bool, NoteModel.SingleNote.ViewModel)!

    func displayNote(_ viewModel: NoteModel.SingleNote.ViewModel) {
        displayNoteCalled = (true, viewModel)
    }
}
