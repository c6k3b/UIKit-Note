import UIKit

class ListViewController: UIViewController {
    // MARK: - Props
    private lazy var table: NotesTableView = {
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(NotesTableView())

    private lazy var floatingButton: FloatingButton = {
        $0.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        return $0
    }(FloatingButton())

    private let worker: WorkerType = Worker()
    private var notes = [Note]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        setupUI()
        addNotes(from: SampleData.notes)
        worker.fetch { [weak self] notesData in
            guard let self = self else { return }
            self.addNotes(from: notesData)
        }
=======
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
<<<<<<< HEAD
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem
=======
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.estimatedRowHeight = 90
    }
>>>>>>> main

        view.addSubview(table)
        view.addSubview(floatingButton)
>>>>>>> c6c39561245dc8877785db0976a34e1d3136ccfc
    }

<<<<<<< HEAD
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
        floatingButton.layer.opacity = 1
=======
        table.translatesAutoresizingMaskIntoConstraints = false
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
>>>>>>> main
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
        view.addSubview(floatingButton)
    }

    private func addNotes(from data: [NoteData]) {
        data.forEach { note in
            notes.append(
                Note(
                    header: note.header,
                    body: note.text,
                    date: Date(timeIntervalSince1970: TimeInterval(note.date ?? 0))
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
<<<<<<< HEAD
    func numberOfSections(in tableView: UITableView) -> Int { notes.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
=======
    func numberOfSections(in tableView: UITableView) -> Int {
        notes.count
    }
>>>>>>> main

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.section]

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteCell.identifier,
            for: indexPath
        ) as? ConfigurableCell else {
            return UITableViewCell()
        }
<<<<<<< HEAD

        cell.configure(
            header: note.header ?? "N/A",
            body: note.body ?? "N/A",
            date: note.date.getFormattedDate(format: "dd MM yyyy")
        )
        return cell as? UITableViewCell ?? UITableViewCell()
=======
        let note = notes[indexPath.section]
        cell.configure(
            header: note.header ?? "N/A",
            body: note.body ?? "N/A",
            date: note.date.getFormattedDate(format: "dd MM yyyy")
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController(note: notes[indexPath.section])
        noteVC.noteDelegate = self
        navigationController?.pushViewController(noteVC, animated: true)
>>>>>>> main
    }
}

// MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 4 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
<<<<<<< HEAD
=======
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        4
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
>>>>>>> main
    }

    func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.section)
<<<<<<< HEAD
            tableView.deleteSections([indexPath.section], with: .automatic)
=======
            tableView.deleteSections([indexPath.section], with: .fade)
>>>>>>> main
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
