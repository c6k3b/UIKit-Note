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
        table.setEditing(editing, animated: true)
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
        table.allowsSelectionDuringEditing = true
        table.allowsMultipleSelectionDuringEditing = true
        table.indicatorStyle = .default

        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.estimatedRowHeight = 90

        table.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)

        view.addSubview(table)
        activateTableViewConstraints()
    }

    private func setupFloatingButton() {
        floatingButton.layer.cornerRadius = 25
        floatingButton.clipsToBounds = true
        floatingButton.contentVerticalAlignment = .bottom
        floatingButton.titleLabel?.font = .systemFont(ofSize: 36)
        floatingButton.backgroundColor = .systemBlue
        floatingButton.setImage(UIImage(named: !table.isEditing ? "buttonPlus" : "buttonTrash"), for: .normal)

        view.addSubview(floatingButton)
        activateFloatingButtonConstraints()

        floatingButton.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        floatingButton.shake()
    }

    private func setupDelegates() {
        table.dataSource = self
        table.delegate = self
    }

    @objc private func didFloatingButtonTapped() {
        if !isEditing {
            let noteVC = NoteViewController(note: Note())
            noteVC.noteDelegate = self
            navigationController?.pushViewController(noteVC, animated: true)
        }

        table.indexPathsForSelectedRows?.forEach({ index in
            notes.remove(at: index.row)
            table.deleteSections([index.section], with: .left)
        })
        table.reloadData()
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
        ) as? NoteCell else {
            return UITableViewCell()
        }

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
    // cell appearance
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 4 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }

    // swipe for delete
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
        }
    }

    // action on tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditing {
            let noteVC = NoteViewController(note: notes[indexPath.section])
            noteVC.noteDelegate = self
            navigationController?.pushViewController(noteVC, animated: true)
        } else {
            if let cell = tableView.cellForRow(at: indexPath) as? NoteCell {
                cell.shake()
            }
        }
    }

    // remove delete button
//    func tableView(
//        _ tableView: UITableView,
//        editingStyleForRowAt indexPath: IndexPath
//    ) -> UITableViewCell.EditingStyle {
//        if isEditing { return .none }
//        return .delete
//    }

    // deselect fading
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
//           indexPathForSelectedRow == indexPath {
//            tableView.deselectRow(at: indexPath, animated: true)
//            return nil
//        }
//        return indexPath
//    }
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

// MARK: - Constraints
extension ListViewController {
    private func activateTableViewConstraints() {
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

    private func activateFloatingButtonConstraints() {
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
}
