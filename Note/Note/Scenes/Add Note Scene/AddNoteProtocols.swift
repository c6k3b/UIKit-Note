protocol AddNoteDataStore {}

protocol AddNoteBusinessLogic {
    func requestNote(_ request: AddNoteModel.InitForm.Request)
}

protocol AddNoteWorkerLogic {}

protocol AddNotePresentationLogic {
    func presentNote(_ response: AddNoteModel.InitForm.Response)
}

protocol AddNoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: AddNoteModel.InitForm.ViewModel)
}

protocol AddNoteRoutingLogic {}

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}
