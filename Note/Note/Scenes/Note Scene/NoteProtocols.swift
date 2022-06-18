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
    func presentEmptyFieldsAlert(_ response: NoteModel.Alert.Response)
}

protocol NoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: NoteModel.PresentNote.ViewModel)
    func displayEmptyFieldsAlert(_ viewModel: NoteModel.Alert.ViewModel)
}

protocol NoteRoutingLogic {
    func route()
}
