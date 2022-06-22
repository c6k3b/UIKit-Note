import Foundation
@testable import Note

final class NotePresenterMock: NotePresentationLogic {
    func presentNote(_ response: NoteModel.PresentNote.Response) {
    }

    func presentEmptyFieldsAlert(_ response: NoteModel.Alert.Response) {
    }
}
