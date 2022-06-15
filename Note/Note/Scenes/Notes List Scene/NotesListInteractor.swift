import UIKit

final class NotesListInteractor: NotesListBusinessLogic, NotesListDataStore {
    private let presenter: NotesListPresentationLogic
    private let worker: NotesListWorkerLogic
    private(set) var notes: [Note] = []

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
                self.notes = noteData.map {
                    Note(
                        header: $0.header,
                        body: $0.text,
                        date: Date(
                            timeIntervalSince1970: TimeInterval($0.date ?? 0)
                        ),
                        icon: UIImage(
                            data: self.worker.fetchImage(
                                from: $0.userShareIcon ?? ""
                            ) ?? Data()
                        )
                    )
                }
            }
            self.presenter.presentNotesList(
                NotesListModel.ShowNotesList.Response(notes: self.notes)
            )
        }
    }
}
