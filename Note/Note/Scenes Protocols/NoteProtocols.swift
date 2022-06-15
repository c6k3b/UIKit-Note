protocol NoteDisplayLogic: AnyObject {
    func displayNote(_ viewModel: NoteModel.InitForm.ViewModel)
}

protocol NoteBusinessLogic {
    func requestNote(_ request: NoteModel.InitForm.Request)
}

protocol NotePresentationLogic {
    func presentNote(_ response: NoteModel.InitForm.Response)
}

protocol NoteWorkerLogic {}

protocol NoteDataStore {}

protocol NoteRoutingLogic {}

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}
