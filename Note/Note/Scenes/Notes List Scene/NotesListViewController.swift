import UIKit

final class NotesListViewController: UIViewController, NotesListDisplayLogic {
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

    private let interactor: NotesListBusinessLogic
    private let router: NotesListRoutingLogic
    private lazy var notes: [Note] = []

    // MARK: - Initializers
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
        floatingButton.layer.opacity = 1
    }

    private func initForm() {
        interactor.requestNotesList(NotesListModel.ShowNotesList.Request())
    }

    func displayNotesList(_ viewModel: NotesListModel.ShowNotesList.ViewModel) {
        notes = viewModel.notes

        DispatchQueue.main.async {
            self.table.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: true)
        editButtonItem.title = !table.isEditing ? "Выбрать" : "Готово"
        floatingButton.setImage(UIImage(named: !table.isEditing ? "buttonPlus" : "buttonTrash"), for: .normal)
        floatingButton.shakeHorizontaly()
    }

    // MARK: - Methods
    @objc private func didFloatingButtonTapped() {
        !isEditing ? pushNoteVC(NoteViewController(note: Note())) : removeNotes()
    }

    private func removeNotes() {
        guard let indexPath = table.indexPathsForSelectedRows?.sorted(by: >) else {
            return showEmptySelectionAlert()
        }
        let noteIndexesToRemove = indexPath.map { $0.section }
        let sectionsForRemove = IndexSet(noteIndexesToRemove)

        noteIndexesToRemove.forEach { notes.remove(at: $0) }
        table.beginUpdates()
        table.deleteSections(sectionsForRemove, with: .automatic)
        table.endUpdates()

        isEditing = false
    }

    private func pushNoteVC(_ viewController: NoteViewController) {
        table.isUserInteractionEnabled = false

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            viewController.noteDelegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
            self.table.isUserInteractionEnabled = true
        }
        floatingButton.shakeOnDisappear()
        UIView.animate(withDuration: 0.2, delay: 0.6, options: []) {
            self.floatingButton.layer.opacity = 0
        }
        CATransaction.commit()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        view.addSubview(floatingButton)
        view.addSubview(activityIndicator)
    }
}

// MARK: - Datasource
    extension NotesListViewController: UITableViewDataSource {
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
                date: note.date.getFormattedDate(format: "dd MM yyyy"),
                icon: note.icon
            )
            return cell as? UITableViewCell ?? UITableViewCell()
        }
    }

// MARK: - Delegate
extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 4 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditing { pushNoteVC(NoteViewController(note: notes[indexPath.section])) }
    }
}

// MARK: - Alerts
extension NotesListViewController {
    private func showEmptySelectionAlert() {
        let alert = UIAlertController(
            title: "Вы не выбрали ни одной заметки",
            message: nil,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)

        present(alert, animated: true)
    }
}

// MARK: - Note Delegate
extension NotesListViewController: NoteDelegate {
    func passData(from note: Note, isChanged: Bool) {
        if isChanged {
            if let index = notes.firstIndex(where: { $0 === note }) {
                notes[index] = note
            } else {
                notes.append(note)
            }
            table.reloadData()
        }
    }
}
