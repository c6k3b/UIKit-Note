import UIKit

final class NotesListInteractor: NotesListBusinessLogic, NotesListDataStore {
    private let presenter: NotesListPresentationLogic
    private let worker: NotesListWorkerLogic
    private(set) var notes: [Note]?

    init(
        presenter: NotesListPresentationLogic,
        worker: NotesListWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestNotesList(_ request: NotesListModel.ShowNotesList.Request) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.worker.fetchData { noteData in
                noteData.forEach { note in
                    self.notes?.append(
                        Note(
                            header: note.header,
                            body: note.text,
                            date: Date(
                                timeIntervalSince1970: TimeInterval(note.date ?? 0)
                            ),
                            icon: UIImage(
                                data: self.worker.fetchImage(
                                    from: note.userShareIcon ?? ""
                                ) ?? Data()
                            )
                        )
                    )
                }
            }
        }

        guard let notes = notes else { return }
        self.presenter.presentNotesList(
            NotesListModel.ShowNotesList.Response(notes: notes)
        )
    }
}
