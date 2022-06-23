import Foundation

final class NotePresenter: NotePresentationLogic {
    weak var view: NoteDisplayLogic?

    func presentNote(_ response: NoteModel.PresentNote.Response) {
        let viewModel = NoteModel.PresentNote.ViewModel(
            date: (response.note.date ?? Date()).getFormattedDate(
                format: Styles.DateFormat.inView
            ),
            header: response.note.header ?? "",
            body: response.note.body ?? ""
        )
        view?.displayNote(viewModel)
    }

    func presentEmptyFieldsAlert(_ response: NoteModel.Alert.Response) {
        let viewModel = NoteModel.Alert.ViewModel(
            title: Styles.AlertEmpty.title,
            message: Styles.AlertEmpty.message,
            actionTitle: Styles.AlertEmpty.actionTitle
        )
        view?.displayEmptyFieldsAlert(viewModel)
    }
}
