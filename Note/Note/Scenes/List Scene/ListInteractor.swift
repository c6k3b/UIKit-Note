import Foundation

final class ListInteractor: ListBusinessLogic, ListDataStore {
    // MARK: - Props
    private let presenter: ListPresentationLogic
    private let worker: ListWorkerLogic
    private(set) var notes: [Note] = []
    var note: Note = Note()
    private var index: Int?

    // MARK: - Initializers
    init(presenter: ListPresentationLogic, worker: ListWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Methods
    func requestNotes(_ request: ListModel.PresentList.Request) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.notes = self.worker.getNotes()
            let response = ListModel.PresentList.Response(notes: self.notes)
            self.presenter.presentNotes(response)
        }
    }

    func getSelectedNoteIndex(_ index: Int?) {
        if let index = index {
            self.note = notes[index]
            self.index = index
        }
    }

    func removeNote(at index: Int) {
        notes.remove(at: index)
        let response = ListModel.PresentList.Response(notes: self.notes)
        presenter.presentNotes(response)
    }

    func updateNotesList() {
        if let index = index {
            notes[index] = note
        } else if index == nil && ((note.header != nil) || (note.body != nil)) {
            notes.append(note)
        }

        let response = ListModel.PresentList.Response(notes: self.notes)
        presenter.presentNotes(response)

        index = nil
        note = Note()
    }

    func showNoSelectionAlert() {
        let response = ListModel.Alert.Response()
        presenter.presentNoSelectionAlert(response)
    }
}
