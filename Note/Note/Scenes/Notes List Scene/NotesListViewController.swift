import UIKit

final class NotesListViewController: UIViewController, NotesListDisplayLogic {
    private let interactor: NotesListBusinessLogic
    private let router: NotesListRoutingLogic

    private lazy var table: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.allowsMultipleSelectionDuringEditing = true
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 90

        $0.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)

//        $0.dataSource = self
//        $0.delegate = self
        return $0
    }(UITableView())

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
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        activateTableViewConstraints()
    }

    private func activateTableViewConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
            table.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16
            ).isActive = true
            table.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -16
            ).isActive = true
            table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func displayInitForm(_ viewModel: NotesListModels.InitForm.ViewModel) {}

    private func initForm() {
        interactor.requestInitForm(NotesListModels.InitForm.Request(note: Note()))
    }
}
