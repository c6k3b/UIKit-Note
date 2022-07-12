import UIKit

protocol ListDataPassing: AnyObject {
    var dataStore: ListDataStore { get }
}

protocol ListDataStore: AnyObject {
    var notes: [Note] { get set }
    var note: Note { get set }
}

protocol ListBusinessLogic: AnyObject {
    func fetchNotes(_ request: ListModel.NotesList.Request)
    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request)
    func storeSelectedNote(_ index: Int?)
}

protocol ListWorkerLogic: AnyObject {
    func getNotes(completion: ([Note]?) -> Void)
}

protocol ListPresentationLogic: AnyObject {
    func presentNotes(_ response: ListModel.NotesList.Response)
    func presentNotesRemoving(_ response: ListModel.NotesRemoving.Response)
}

protocol ListDisplayLogic: AnyObject {
    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel)
    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel)
}

protocol ListRoutingLogic: AnyObject {
    func route()
}

protocol ConfigurableCell: AnyObject {
    func configure(with model: NoteCell.Model)
}
