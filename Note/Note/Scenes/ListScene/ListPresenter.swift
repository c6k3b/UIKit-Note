import UIKit

final class ListPresenter: ListPresentationLogic {
    weak var view: ListDisplayLogic?

    func presentNotes(_ response: ListModel.NotesList.Response) {
        var presentedNotes: [NoteCell.NoteViewModel] = []
        for note in response.notes {
            let presentedNote = NoteCell.NoteViewModel(
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
        view?.displayNotes(viewModel)
    }

    func presentNoSelectionAlert(_ response: ListModel.Alert.Response) {
        let viewModel = ListModel.Alert.ViewModel(
            title: Styles.AlertNoSelection.title,
            message: Styles.AlertNoSelection.message,
            actionTitle: Styles.AlertNoSelection.actionTitle
        )
        view?.displayNoSelectionAlert(viewModel)
    }
}
