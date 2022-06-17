import UIKit

final class ListRouter: ListRoutingLogic, ListDataPassing {
    // MARK: - Props
    weak var viewController: UIViewController?
    weak var table: UITableView?
    var dataStore: ListDataStore

    // MARK: - Initializers
    init(dataStore: ListDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - Routing
    func route() {
        let destinationVC = NoteAssembly.build() as? NoteViewController
        var destinationDS = destinationVC?.router.dataStore
        passData(source: dataStore, destination: &destinationDS!)
        navigate(source: viewController!, destination: destinationVC!)
    }

    // MARK: - Navigation
    private func navigate(source: UIViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: - Passing data
    private func passData(source: ListDataStore, destination: inout NoteDataStore) {
        destination.note = source.note
    }
}
