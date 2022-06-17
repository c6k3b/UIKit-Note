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

    func displayNote(_ request: NoteModel.PresentNote.Request) {
        presenter.presentNote(NoteModel.PresentNote.Response(note: note))
    }

    func saveNote(_ request: NoteModel.SaveNote.Request) {
        guard let date = request.date, !date.isEmpty,
              let header = request.header, !header.isEmpty,
              let body = request.body, !body.isEmpty
        else { return }

        note.header = header
        note.body = body
    }
}
