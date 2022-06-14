final class AddNotePresenter: AddNotePresentationLogic {
    weak var view: AddNoteDisplayLogic?

    func presentNote(_ response: AddNoteModel.InitForm.Response) {
        view?.displayNote(AddNoteModel.InitForm.ViewModel())
    }
}
