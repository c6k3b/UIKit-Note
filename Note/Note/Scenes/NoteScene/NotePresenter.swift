import Foundation

final class NotePresenter: NotePresentationLogic {
    // MARK: - Props
    weak var viewController: NoteDisplayLogic?

    // MARK: - Methods
    func presentNote(_ response: NoteModel.SingleNote.Response) {
        if (response.note.header != "") || (response.note.body != "") {
            let viewModel = NoteModel.SingleNote.ViewModel.success(
                note: NoteView.Model(
                    header: response.note.header ?? "",
                    body: response.note.body ?? "",
                    date: (response.note.date ?? Date()).getFormattedDate(
                        format: Styles.DateFormat.inView
                    )
                )
            )
            viewController?.displayNote(viewModel)
        } else {
            let viewModel = NoteModel.SingleNote.ViewModel.failure(
                alert: NoteModel.SingleNote.ViewModel.Alert(
                    title: Styles.AlertEmptyNoteHeaderOrBody.title,
                    message: Styles.AlertEmptyNoteHeaderOrBody.message,
                    actionTitle: Styles.AlertEmptyNoteHeaderOrBody.actionTitle
                )
            )
            viewController?.displayNote(viewModel)
        }
    }
}
