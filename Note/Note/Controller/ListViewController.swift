import UIKit

class ListViewController: UIViewController {
    // MARK: - Props
    private lazy var table: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.allowsMultipleSelectionDuringEditing = true
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 90

        $0.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)

        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView())

    private lazy var floatingButton: FloatingButton = {
        $0.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        return $0
    }(FloatingButton())

    private let worker: WorkerType = Worker()
    private let decoder: DecoderType = Decoder()
    private var notes = [Note]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        worker.fetch { decoder.decode($0) { addNotes(from: $0) } }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
        floatingButton.layer.opacity = 1
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

    private func setupUI() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        activateTableViewConstraints()

        view.addSubview(floatingButton)
    }

    private func addNotes(from data: [NoteData]) {
        data.forEach { note in
            notes.append(
                Note(
                    header: note.header,
                    body: note.text,
                    date: Date(timeIntervalSince1970: TimeInterval(note.date ?? 0)),
                    icon: note.userShareIcon
                )
            )
        }
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

    private func removeNotes() {
        guard let cellsForRemove = table.indexPathsForSelectedRows?.sorted(by: >) else {
            showEmptySelectionAlert()
            return
        }

        cellsForRemove.forEach {
            table.beginUpdates()
            notes.remove(at: $0.section)
            table.deleteSections([$0.section], with: .automatic)
            table.endUpdates()
        }
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
        ) as? ConfigurableNoteView else {
            return UITableViewCell()
        }

        cell.configure(
            with: NoteViewModel(
                header: note.header,
                body: note.body,
                date: note.date.getFormattedDate(format: "dd MM yyyy"),
                icon: note.icon
            )
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
            notes.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditing { pushNoteVC(NoteViewController(note: notes[indexPath.section])) }
    }
}

// MARK: - Note Delegate
extension ListViewController: NoteDelegate {
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

// MARK: - Alerts
extension ListViewController {
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

// MARK: - Constraints
extension ListViewController {
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
}
