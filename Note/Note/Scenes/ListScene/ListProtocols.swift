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
    func remove(_ index: [Int]?)
    func update()
    func getSelectedNoteIndex(_ index: Int?)
}

protocol ListWorkerLogic {
    func getNotes(completion: ([Note]?) -> Void)
}

protocol ListPresentationLogic {
    func presentNotes(_ response: ListModel.NotesList.Response)
    func presentNoSelectionAlert(_ response: ListModel.Alert.Response)
}

protocol ListDisplayLogic: AnyObject {
    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel)
    func displayNoSelectionAlert(_ viewModel: ListModel.Alert.ViewModel)
}

protocol ListRoutingLogic {
    func route()
}

protocol ConfigurableCell {
    func configure(with model: NoteCell.NoteViewModel)
}
