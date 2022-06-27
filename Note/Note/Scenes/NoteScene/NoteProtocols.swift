protocol NoteDataPassing {
    var dataStore: NoteDataStore { get }
}

protocol NoteDataStore {
    var note: Note { get set }
}

protocol NoteBusinessLogic {
    func requestNote(_ request: NoteModel.SingleNote.Request)
    func saveNote(_ request: NoteModel.NoteSaving.Request)
}

protocol NoteWorkerLogic {}

protocol NotePresentationLogic {
    func presentNote(_ response: NoteModel.SingleNote.Response)
}

protocol NoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: NoteModel.SingleNote.ViewModel)
}

protocol NoteRoutingLogic {
    func route()
}
