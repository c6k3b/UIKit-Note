import UIKit

protocol NotesListDataStore {
    var notes: [Note] { get }
}

protocol NotesListBusinessLogic {
    func requestNotesList(_ request: NotesListModel.ShowNotesList.Request)
}

protocol NotesListWorkerLogic {
    func fetchData(completion: ([NoteData]) -> Void)
    func fetchImage(from stringUrl: String) -> Data?
}

protocol NotesListPresentationLogic {
    func presentNotesList(_ response: NotesListModel.ShowNotesList.Response)
}

protocol NotesListDisplayLogic: AnyObject {
    func displayNotesList(_ viewModel: NotesListModel.ShowNotesList.ViewModel)
}

protocol NotesListRoutingLogic {}

protocol ConfigurableCell {
    func configure(header: String?, body: String?, date: String, icon: UIImage?)
//    func configure(with viewModel: NotesListModel.ShowNotesList.ViewModel)
}
