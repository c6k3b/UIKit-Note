import UIKit

protocol NotesListDisplayLogic: AnyObject {
    func displayNotesList(_ viewModel: NotesListModel.ShowNotesList.ViewModel)
}

protocol NotesListBusinessLogic {
    func requestNotesList(_ request: NotesListModel.ShowNotesList.Request)
    func removeNotesFromTable(at index: Int)
}

protocol NotesListPresentationLogic {
    func presentNotesList(_ response: NotesListModel.ShowNotesList.Response)
}

protocol NotesListWorkerLogic {
    func fetchData(completion: ([NoteData]) -> Void)
    func fetchImage(from stringUrl: String) -> Data?
}

protocol NotesListDataStore {
    var notes: [Note] { get }
}

protocol NotesListRoutingLogic {
    func passDataTo(source: NotesListDataStore, destination: inout NoteDataStore)
}

protocol ConfigurableCell {
    func configure(header: String?, body: String?, date: String, icon: UIImage?)
//    func configure(with viewModel: NotesListModel.ShowNotesList.ViewModel)
}
