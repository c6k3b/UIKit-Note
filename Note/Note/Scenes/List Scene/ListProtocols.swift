import UIKit

protocol ListDataPassing {
    var dataStore: ListDataStore { get }
}

protocol ListDataStore {
    var notes: [Note] { get }
    var note: Note { get set }
}

protocol ListBusinessLogic {
    func requestNotes(_ request: ListModel.PresentList.Request)
    func getSelectedNoteIndex(_ index: Int?)
    func removeNote(at index: Int)
    func showNoSelectionAlert()
    func updateNotesList()
}

protocol ListWorkerLogic {
    func getNotes() -> [Note]
}

protocol ListPresentationLogic {
    func presentNotes(_ response: ListModel.PresentList.Response)
    func presentNoSelectionAlert(_ response: ListModel.Alert.Response)
}

protocol ListDisplayLogic: AnyObject {
    func displayNotes(_ viewModel: ListModel.PresentList.ViewModel)
    func displayNoSelectionAlert(_ viewModel: ListModel.Alert.ViewModel)
}

protocol ListRoutingLogic {
    func route()
}

protocol ConfigurableCell {
    func configure(header: String?, body: String?, date: String, icon: UIImage?)
}
