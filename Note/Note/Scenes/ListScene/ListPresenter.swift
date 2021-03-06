import UIKit

final class ListPresenter: ListPresentationLogic {
    // MARK: - Props
    weak var viewController: ListDisplayLogic?

    // MARK: - Methods
    func presentNotes(_ response: ListModel.NotesList.Response) {
        var presentedNotes: [NoteCell.Model] = []
        for note in response.notes {
            let presentedNote = NoteCell.Model(
                header: note.header ?? "",
                body: note.body ?? "",
                date: (note.date ?? Date()).getFormattedDate(
                    format: Styles.DateFormat.inCell
                ),
                icon: UIImage(data: note.icon ?? Data()) ?? UIImage()
            )
            presentedNotes.append(presentedNote)
        }

        let viewModel = ListModel.NotesList.ViewModel(
            notes: presentedNotes
        )
        viewController?.displayNotes(viewModel)
    }

    func presentNotesRemoving(_ response: ListModel.NotesRemoving.Response) {
        if !response.indicesToRemove.isEmpty {
            viewController?.displayNotesRemoving(
                ListModel.NotesRemoving.ViewModel.success(indicesToRemove: response.indicesToRemove)
            )
        } else {
            viewController?.displayNotesRemoving(
                ListModel.NotesRemoving.ViewModel.failure(
                    alert: ListModel.NotesRemoving.ViewModel.Alert(
                        title: Styles.AlertNoSelectionForDeleteNotes.title,
                        message: Styles.AlertNoSelectionForDeleteNotes.message,
                        actionTitle: Styles.AlertNoSelectionForDeleteNotes.actionTitle
                    )
                )
            )
        }
    }
}
