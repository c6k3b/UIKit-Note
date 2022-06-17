protocol NoteDataPassing {
    var dataStore: NoteDataStore { get }
}

protocol NoteDataStore {
    var note: Note { get set }
}

protocol NoteBusinessLogic {
    func displayNote(_ request: NoteModel.PresentNote.Request)
    func saveNote(_ request: NoteModel.SaveNote.Request)
}

protocol NoteWorkerLogic {}

protocol NotePresentationLogic {
    func presentNote(_ response: NoteModel.PresentNote.Response)
}

protocol NoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: NoteModel.PresentNote.ViewModel)
}

protocol NoteRoutingLogic {
    func route()
}

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}
