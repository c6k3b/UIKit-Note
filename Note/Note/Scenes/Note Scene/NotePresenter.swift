import Foundation

final class NotePresenter: NotePresentationLogic {
    weak var view: NoteDisplayLogic?

    func presentNote(_ response: NoteModel.PresentNote.Response) {
        let viewModel = NoteModel.PresentNote.ViewModel(
            date: (response.note.date ?? Date()).getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm"),
            header: response.note.header ?? "",
            body: response.note.body ?? ""
        )
        view?.displayNote(viewModel)
    }

    func presentEmptyFieldsAlert(_ response: NoteModel.Alert.Response) {
        let viewModel = NoteModel.Alert.ViewModel(
            title: "Поля не заполнены",
            message: "Не могу сохранить пустую заметку",
            actionTitle: "Редактировать"
        )
        view?.displayEmptyFieldsAlert(viewModel)
    }
}
