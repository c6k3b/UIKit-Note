import Foundation

final class NotePresenter: NotePresentationLogic {
    weak var view: NoteDisplayLogic?

    func presentNote(_ response: NoteModel.PresentNote.Response) {
        let viewModel = NoteModel.PresentNote.ViewModel(
            date: (response.note.date ?? Date()).getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm"),
            header: response.note.header ?? "N/A",
            body: response.note.body ?? "N/A"
        )
        view?.displayNote(viewModel)
    }
}
