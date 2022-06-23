import UIKit

protocol ListDataPassing {
    var dataStore: ListDataStore { get }
}

protocol ListDataStore {
    var notes: [Note] { get }
    var note: Note { get set }
}

protocol ListBusinessLogic {
    func request(_ request: ListModel.PresentList.Request)
    func remove(_ index: [Int]?)
    func update()
    func getSelectedNoteIndex(_ index: Int?)
}

protocol ListWorkerLogic {
    func getNotes(completion: ([Note]?) -> Void)
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
