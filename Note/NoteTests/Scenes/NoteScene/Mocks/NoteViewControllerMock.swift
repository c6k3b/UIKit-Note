import Foundation
@testable import Note

final class NoteViewControllerMock: NoteDisplayLogic {
    var viewControllerWasCalled = false

    func displayNote(_ viewModel: NoteModel.SingleNote.ViewModel) {
    }
}
