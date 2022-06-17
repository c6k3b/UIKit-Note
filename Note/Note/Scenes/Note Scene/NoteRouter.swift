import UIKit

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
    // MARK: - Props
    weak var viewController: UIViewController?
    var dataStore: NoteDataStore

    // MARK: - Initializers
    init(dataStore: NoteDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - Routing
    func route() {
        let index = viewController!.navigationController!.viewControllers.count - 2
        let destinationVC = viewController!.navigationController?.viewControllers[index] as? ListViewController
        var destinationDS = destinationVC?.router.dataStore
        passData(source: dataStore, destination: &destinationDS!)
        navigate()
    }

    // MARK: - Navigation
    private func navigate() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    // MARK: - Passing Data
    private func passData(source: NoteDataStore, destination: inout ListDataStore) {
        destination.note = source.note
    }
}
