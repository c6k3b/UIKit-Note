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
        let response = NoteModel.PresentNote.Response(note: note)
        presenter.presentNote(response)
    }

    func saveNote(_ request: NoteModel.SaveNote.Request) {
        guard let header = request.header, !header.isEmpty,
              let body = request.body, !body.isEmpty
        else { return }

        note.date = Date()
        note.header = header
        note.body = body

        let response = NoteModel.PresentNote.Response(note: note)
        presenter.presentNote(response)
    }
}
