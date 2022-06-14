import Foundation

final class NotesListPresenter: NotesListPresentationLogic {
    weak var view: NotesListDisplayLogic?

    func presentNotesList(
        _ response: NotesListModel.ShowNotesList.Response
    ) {
        view?.displayNotesList(
            NotesListModel.ShowNotesList.ViewModel(
                notes: response.notes
            )
        )
    }
}
