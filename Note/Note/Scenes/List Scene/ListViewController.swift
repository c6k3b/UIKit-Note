import UIKit

final class ListViewController: UIViewController, ListDisplayLogic {
    // MARK: - Props
    private let activityIndicator = ActivityIndicator(frame: .zero)

    private lazy var table: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(NotesTableView())

    private lazy var floatingButton: FloatingButton = {
        $0.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        return $0
    }(FloatingButton())

    private let interactor: ListBusinessLogic
    let router: (ListRoutingLogic & ListDataPassing)
    private var notes: [ListModel.PresentList.ViewModel.PresentedNoteCell] = []

    // MARK: - Initializers
    init(interactor: ListBusinessLogic, router: ListRoutingLogic & ListDataPassing) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - DisplayLogic
    func displayNotes(_ viewModel: ListModel.PresentList.ViewModel) {
        notes = viewModel.presentedCells
        self.activityIndicator.stopAnimating()
        self.table.reloadData()
    }

    func displayNoSelectionAlert(_ viewModel: ListModel.Alert.ViewModel) {
        showAlert(
            title: viewModel.title,
            message: viewModel.message,
            actionTitle: viewModel.actionTitle
        )
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.request(ListModel.PresentList.Request())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
        floatingButton.layer.opacity = 1
        self.interactor.update()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: true)
        editButtonItem.title = !table.isEditing ? "Выбрать" : "Готово"
        floatingButton.setImage(UIImage(named: !table.isEditing ? "buttonPlus" : "buttonTrash"), for: .normal)
        floatingButton.shakeHorizontaly()
    }

    // MARK: - Routing
    @objc private func didFloatingButtonTapped() {
        !isEditing ? navigate() : remove()
    }

    private func navigate() {
        table.isUserInteractionEnabled = false

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.router.route()
            self.table.isUserInteractionEnabled = true
        }
        floatingButton.shakeOnDisappear()
        UIView.animate(withDuration: 0.2, delay: 0.6, options: []) {
            self.floatingButton.layer.opacity = 0
        }
        CATransaction.commit()
    }

    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        view.addSubview(floatingButton)
        view.addSubview(activityIndicator)
    }

    private func remove() {
        guard let indexPath = table.indexPathsForSelectedRows?.sorted(by: >) else {
            return interactor.showNoSelectionAlert()
        }
        let noteIndexesToRemove = indexPath.map { $0.section }
        let sectionsForRemove = IndexSet(noteIndexesToRemove)

        table.beginUpdates()
        interactor.remove(noteIndexesToRemove)
        table.deleteSections(sectionsForRemove, with: .left)
        table.endUpdates()

        isEditing = false
    }
}

// MARK: - Datasource
    extension ListViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int { notes.count }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let note = notes[indexPath.section]

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NoteCell.identifier,
                for: indexPath
            ) as? ConfigurableCell else {
                return UITableViewCell()
            }

            cell.configure(
                header: note.header,
                body: note.body,
                date: note.date,
                icon: note.icon
            )
            return cell as? UITableViewCell ?? UITableViewCell()
        }
    }

// MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 4 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            table.beginUpdates()
            interactor.remove([indexPath.section])
            tableView.deleteSections([indexPath.section], with: .left)
            table.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.getSelectedNoteIndex(indexPath.section)
        if !isEditing { navigate() }
    }
}
