import Foundation

final class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    private let presenter: NotePresentationLogic
    private let worker: NoteWorkerLogic
    var note: Note = Note()

    init(
        presenter: NotePresentationLogic,
        worker: NoteWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestNote(_ request: NoteModel.PresentNote.Request) {
        let response = NoteModel.PresentNote.Response(note: note)
        presenter.presentNote(response)
    }

    func saveNote(_ request: NoteModel.SaveNote.Request) {
        if let header = request.header,
           let body = request.body, (!header.isEmpty || !body.isEmpty) {
            note.date = Date()
            note.header = header
            note.body = body

            let response = NoteModel.PresentNote.Response(note: note)
            presenter.presentNote(response)
        } else {
            let response = NoteModel.Alert.Response()
            presenter.presentEmptyFieldsAlert(response)
        }
    }
}
