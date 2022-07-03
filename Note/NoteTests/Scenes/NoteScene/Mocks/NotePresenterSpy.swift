import Foundation
@testable import Note

final class NotePresenterMock: NotePresentationLogic {
    var presenterWasCalled = false
    var responseMock: NoteModel.SingleNote.Response?
    var responseMockSaving: NoteModel.NoteSaving.Response?

    func presentNote(_ response: NoteModel.SingleNote.Response) {
        presenterWasCalled = true
        responseMock = response
    }
}
