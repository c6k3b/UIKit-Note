import UIKit

protocol ListDataPassing {
    var dataStore: ListDataStore { get }
}

protocol ListDataStore {
    var notes: [Note] { get }
    var note: Note { get set }
}

protocol ListBusinessLogic {
    func fetchNotes(_ request: ListModel.NotesList.Request)
    func update()
    func getSelectedNoteIndex(_ index: Int?)
    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request)
}

protocol ListWorkerLogic {
    func getNotes(completion: ([Note]?) -> Void)
}

protocol ListPresentationLogic {
    func presentNotes(_ response: ListModel.NotesList.Response)
    func presentNotesRemoving(_ response: ListModel.NotesRemoving.Response)
}

protocol ListDisplayLogic: AnyObject {
    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel)
    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel)
}

protocol ListRoutingLogic {
    func route()
}

protocol ConfigurableCell {
    func configure(with model: NoteCell.Model)
}
