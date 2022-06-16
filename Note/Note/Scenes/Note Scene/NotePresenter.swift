import Foundation

final class NotePresenter: NotePresentationLogic {
    weak var view: NoteDisplayLogic?

    func presentNote(_ response: NoteModel.Response) {
        view?.displayNote(
            NoteModel.ViewModel(
                date: Date(),
                header: "Test",
                body: "Test"
            )
        )
    }
}
