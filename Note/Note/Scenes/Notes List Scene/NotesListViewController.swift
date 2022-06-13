import UIKit

final class NotesListViewController: UIViewController, NotesListDisplayLogic {
    private let interactor: NotesListBusinessLogic
    private let router: NotesListRoutingLogic

    init(interactor: NotesListBusinessLogic, router: NotesListRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()

        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem
    }

    func displayInitForm(_ viewModel: NotesListModels.InitForm.ViewModel) {}

    private func initForm() {
        interactor.requestInitForm(NotesListModels.InitForm.Request(note: Note()))
    }
}
