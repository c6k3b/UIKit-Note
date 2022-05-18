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

    private var notes = SampleData().notes

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        view.addSubview(floatingButton)
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

    private func pushNoteVC(_ viewController: NoteViewController) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            viewController.noteDelegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }

        floatingButton.shakeOnDisappear()
        UIView.animate(withDuration: 0.2, delay: 0.6, options: []) {
            self.floatingButton.layer.opacity = 0
        }
        CATransaction.commit()
    }

    private func removeNotes() {
        let cellsForRemove = table.indexPathsForSelectedRows?.sorted(by: >)

        if cellsForRemove == nil {
            showEmptySelectionAlert()
        } else {
            cellsForRemove?.forEach {
                table.beginUpdates()
                notes.remove(at: $0.section)
                table.deleteSections([$0.section], with: .automatic)
                table.endUpdates()
            }
        }
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
            header: note.header ?? "N/A",
            body: note.body ?? "N/A",
            date: note.date.getFormattedDate(format: "dd MM yyyy")
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
