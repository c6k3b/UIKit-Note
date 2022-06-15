import Foundation

final class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    private let presenter: NotePresentationLogic
    private let worker: NoteWorkerLogic

    init(
        presenter: NotePresentationLogic,
        worker: NoteWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestNote(_ request: NoteModel.InitForm.Request) {
//        DispatchQueue.main.async {
//            worker.fetchData() {
                self.presenter.presentNote(NoteModel.InitForm.Response())
//            }
//        }
    }
}
