import Foundation

final class ListInteractor: ListBusinessLogic, ListDataStore {
    // MARK: - Props
    private let presenter: ListPresentationLogic
    private let worker: ListWorkerLogic
    private(set) var notes: [Note] = []
    private(set) var index: Int?
    var note: Note = Note()

    // MARK: - Initializers
    init(presenter: ListPresentationLogic, worker: ListWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Methods
    func fetchNotes(_ request: ListModel.NotesList.Request) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.worker.getNotes {
                if $0 != nil { self.notes = $0! }
            }
            DispatchQueue.main.async {
                let response = ListModel.NotesList.Response(notes: self.notes)
                self.presenter.presentNotes(response)
            }
        }
    }

    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request) {
        presenter.presentNotesRemoving(
            ListModel.NotesRemoving.Response(indicesToRemove: request.indicesToRemove)
        )
    }

    func update() {
        if let index = index {
            notes[index] = note
        } else if index == nil && ((note.header != nil) || (note.body != nil)) {
            notes.append(note)
        }

        let response = ListModel.NotesList.Response(notes: self.notes)
        presenter.presentNotes(response)

        index = nil
        note = Note()
    }

    func getSelectedNoteIndex(_ index: Int?) {
        if let index = index {
            self.note = notes[index]
            self.index = index
        }
    }
}
