final class NotePresenter: NotePresentationLogic {
    weak var view: NoteDisplayLogic?

    func presentNote(_ response: NoteModel.InitForm.Response) {
        view?.displayNote(NoteModel.InitForm.ViewModel())
    }
}
