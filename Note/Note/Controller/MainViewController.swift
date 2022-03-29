import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Props
    typealias Navigation = Styles.Navigation
    
    private let mainView = MainView()
    var repository: Repository?
    
    override func loadView() {
        setView()
        setNavigationAppearance()
    }
    
    private func setView() {
        view = mainView
    }
    
    private func setNavigationAppearance() {
        navigationItem.title = "Note"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Navigation.titleFont]
        navigationItem.rightBarButtonItem = mainView.rightBarButton
    }
}
