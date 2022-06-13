import Foundation
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

    func requestInitForm(_ request: NotesListModels.InitForm.Request) {
        DispatchQueue.main.async {
            self.worker.fetch { _ in
                self.presenter.presentInitForm(NotesListModels.InitForm.Response(notes: self.notes))
            }
        }
    }

    private func addNotes() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.worker.fetch { noteData in
                noteData.forEach { note in
                    self.notes.append(
                        Note(
                            header: note.header,
                            body: note.text,
                            date: Date(
                                timeIntervalSince1970: TimeInterval(note.date ?? 0)
                            ),
                            icon: UIImage(
                                data: self.worker.getImageData(
                                    from: note.userShareIcon ?? ""
                                ) ?? Data()
                            )
                        )
                    )
                }
            }
        }
    }

//    func passData(from note: Note, isChanged: Bool) {}
}
