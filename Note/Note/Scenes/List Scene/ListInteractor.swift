import Foundation

final class ListInteractor: ListBusinessLogic, ListDataStore {
    // MARK: - Props
    private let presenter: ListPresentationLogic
    private let worker: ListWorkerLogic
    private(set) var notes: [Note] = []
    var note: Note = Note()

    // MARK: - Initializers
    init(presenter: ListPresentationLogic, worker: ListWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Methods
    func requestNotes(_ request: ListModel.Request) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.notes = self.worker.getNotes()
            let response = ListModel.Response(notes: self.notes)
            self.presenter.presentNotes(response)
        }
    }

    func getSelectedNoteIndex(_ index: Int?) {
        if let index = index {
            self.note = notes[index]
        }
    }

    func removeNote(at index: Int) {
        notes.remove(at: index)
        let response = ListModel.Response(notes: self.notes)
        presenter.presentNotes(response)
    }
}
