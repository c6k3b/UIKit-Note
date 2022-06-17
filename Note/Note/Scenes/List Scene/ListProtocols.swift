import UIKit

protocol ListDataPassing {
    var dataStore: ListDataStore { get }
}

protocol ListDataStore {
    var notes: [Note] { get }
    var note: Note { get set }
}

protocol ListBusinessLogic {
    func requestNotes(_ request: ListModel.Request)
    func getSelectedNoteIndex(_ index: Int?)
    func removeNote(at index: Int)
}

protocol ListWorkerLogic {
    func getNotes() -> [Note]
}

protocol ListPresentationLogic {
    func presentNotes(_ response: ListModel.Response)
}

protocol ListDisplayLogic: AnyObject {
    func displayNotes(_ viewModel: ListModel.ViewModel)
}

protocol ListRoutingLogic {
    func route()
}

protocol ConfigurableCell {
    func configure(header: String?, body: String?, date: String, icon: UIImage?)
}
