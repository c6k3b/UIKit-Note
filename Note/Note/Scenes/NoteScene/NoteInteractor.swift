import Foundation

final class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    // MARK: - Props
    private let presenter: NotePresentationLogic
    private let worker: NoteWorkerLogic
    var note: Note = Note()

    // MARK: - Initializers
    init(
        presenter: NotePresentationLogic,
        worker: NoteWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Methods
    func requestNote(_ request: NoteModel.SingleNote.Request) {
        let response = NoteModel.SingleNote.Response(note: note)
        presenter.presentNote(response)
    }

    func saveNote(_ request: NoteModel.NoteSaving.Request) {
        if let header = request.header,
           let body = request.body, (!header.isEmpty || !body.isEmpty) {
            note.date = Date()
            note.header = header
            note.body = body

            let response = NoteModel.SingleNote.Response(note: note)
            presenter.presentNote(response)
        } else {
            let response = NoteModel.Alert.Response()
            presenter.presentEmptyFieldsAlert(response)
        }
    }
}
