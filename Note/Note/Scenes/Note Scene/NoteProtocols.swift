protocol NoteDataPassing {
    var dataStore: NoteDataStore { get }
}

protocol NoteDataStore {
    var note: Note { get set }
}

protocol NoteBusinessLogic {
    func requestNote(_ request: NoteModel.Request)
}

protocol NoteWorkerLogic {}

protocol NotePresentationLogic {
    func presentNote(_ response: NoteModel.Response)
}

protocol NoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: NoteModel.ViewModel)
}

protocol NoteRoutingLogic {
    func route()
}

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}
