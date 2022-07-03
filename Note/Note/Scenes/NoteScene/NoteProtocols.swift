protocol NoteDataPassing: AnyObject {
    var dataStore: NoteDataStore { get }
}

protocol NoteDataStore: AnyObject {
    var note: Note { get set }
}

protocol NoteBusinessLogic {
    func requestNote(_ request: NoteModel.SingleNote.Request)
    func saveNote(_ request: NoteModel.NoteSaving.Request)
}

protocol NoteWorkerLogic: AnyObject {}

protocol NotePresentationLogic: AnyObject {
    func presentNote(_ response: NoteModel.SingleNote.Response)
}

protocol NoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: NoteModel.SingleNote.ViewModel)
}

protocol NoteRoutingLogic: AnyObject {
    func route()
}

protocol ConfigurableView: AnyObject {
    func configure(with model: NoteView.Model)
}
