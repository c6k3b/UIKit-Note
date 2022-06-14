import Foundation

final class AddNoteInteractor: AddNoteBusinessLogic, AddNoteDataStore {
    private let presenter: AddNotePresentationLogic
    private let worker: AddNoteWorkerLogic

    init(
        presenter: AddNotePresentationLogic,
        worker: AddNoteWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestNote(_ request: AddNoteModel.InitForm.Request) {
//        DispatchQueue.main.async {
//            worker.fetchData() {
                self.presenter.presentNote(AddNoteModel.InitForm.Response())
//            }
//        }
    }
}
