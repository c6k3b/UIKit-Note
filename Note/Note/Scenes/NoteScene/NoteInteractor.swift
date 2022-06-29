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
        note.date = Date()
        note.header = request.note.header
        note.body = request.note.body

        let response = NoteModel.SingleNote.Response(note: note)
        presenter.presentNote(response)
    }
}
