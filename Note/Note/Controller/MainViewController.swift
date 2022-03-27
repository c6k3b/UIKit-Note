import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Props
    private var mainView = MainView()
    var repository: Repository?
    
    override func loadView() {
        setRepository()
        setView()
        setNavigationAppearance()
    }
    
    private func setRepository() {
        guard let repository = repository else { return }
        repository.note = Note()
        repository.files = FileSystemOperations()
    }
    
    private func setView() {
        view = mainView
    }
    
    private func setNavigationAppearance() {
        navigationItem.title = "Notes"
        navigationItem.largeTitleDisplayMode = .always
    }
}
