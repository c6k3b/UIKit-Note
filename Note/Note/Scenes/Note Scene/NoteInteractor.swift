import Foundation

final class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    private let presenter: NotePresentationLogic
    private let worker: NoteWorkerLogic
    var notes: [Note] = []

    init(
        presenter: NotePresentationLogic,
        worker: NoteWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestNote(_ request: NoteModel.Request) {
        self.presenter.presentNote(NoteModel.Response(note: Note()))
    }
}
