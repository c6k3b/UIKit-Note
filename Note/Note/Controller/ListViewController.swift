import UIKit

class ListViewController: UIViewController {
    private let floatingButton = UIButton()
    private let table = UITableView()

    private var notes = SampleData().notes

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        setupFloatingButton()
        setupDelegates()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
        editButtonItem.title = !table.isEditing ? "Выбрать" : "Готово"
        setupFloatingButton()
    }

    private func setupNavigation() {
        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem
    }

    private func setupTableView() {
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.estimatedRowHeight = 90
//        table.allowsMultipleSelection = true
        table.allowsSelectionDuringEditing = true
        table.allowsSelectionDuringEditing = true
        table.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)

        view.addSubview(table)

        table.translatesAutoresizingMaskIntoConstraints = false
        table.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 16
        ).isActive = true
        table.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -16
        ).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupFloatingButton() {
        floatingButton.layer.cornerRadius = 25
        floatingButton.clipsToBounds = true
        floatingButton.contentVerticalAlignment = .bottom
        floatingButton.titleLabel?.font = .systemFont(ofSize: 36)
        floatingButton.backgroundColor = .systemBlue
        floatingButton.setImage(UIImage(named: !table.isEditing ? "buttonPlus" : "buttonTrash"), for: .normal)

        view.addSubview(floatingButton)
        floatingButton.shake()

        floatingButton.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)

        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        ).isActive = true
        floatingButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20
        ).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupDelegates() {
        table.dataSource = self
        table.delegate = self
    }

    private func deleteNote(_ indexPath: IndexPath, _ tableView: UITableView) {
        notes.remove(at: indexPath.section)
        tableView.deleteSections([indexPath.section], with: .fade)
    }

    @objc private func didFloatingButtonTapped() {
        if !isEditing {
            let noteVC = NoteViewController(note: Note())
            noteVC.noteDelegate = self
            navigationController?.pushViewController(noteVC, animated: true)
        } else {
//            deleteNote(tableView(table, cellForRowAt: 0), table)
        }
    }
}

// MARK: - Datasource
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { notes.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteCell.identifier,
            for: indexPath
        ) as? NoteCell else {
            return UITableViewCell()
        }
        let note = notes[indexPath.section]
        cell.configure(
            header: note.header ?? "N/A",
            body: note.body ?? "N/A",
            date: note.date.getFormattedDate(format: "dd MM yyyy")
        )
        return cell
    }
}

// MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    // Cell appearance
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 4 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }

    // Removing delete button
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        tableView.isEditing ? .none : .delete
    }

    // Swipe for delete
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            deleteNote(indexPath, tableView)
        }
    }

    // Row select/deselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditing {
            let noteVC = NoteViewController(note: notes[indexPath.section])
            noteVC.noteDelegate = self
            navigationController?.pushViewController(noteVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
           indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: true)
            return nil
        }
        return indexPath
    }
}

extension ListViewController: NoteDelegate {
    func passData(from note: Note, isChanged: Bool) {
        if isChanged {
            if let index = notes.firstIndex(where: { $0 === note }) {
                notes[index] = note
            } else {
                notes.append(note)
            }
        }
        table.reloadData()
    }
 }
