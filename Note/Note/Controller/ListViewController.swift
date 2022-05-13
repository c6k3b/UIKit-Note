import UIKit

class ListViewController: UIViewController {
    // MARK: - Props
    private let table: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.allowsSelectionDuringEditing = true
        $0.allowsMultipleSelectionDuringEditing = true

        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 90

        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
        return $0
    }(UITableView())

    private lazy var floatingButton: UIButton = {
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.contentVerticalAlignment = .bottom
        $0.titleLabel?.font = .systemFont(ofSize: 36)
        $0.backgroundColor = .systemBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "buttonPlus"), for: .normal)
        $0.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())

    private var notes = SampleData().notes

    // MARK: - Lyfecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        table.dataSource = self
        table.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: true)
        editButtonItem.title = !table.isEditing ? "Выбрать" : "Готово"
        floatingButton.setImage(UIImage(named: !table.isEditing ? "buttonPlus" : "buttonTrash"), for: .normal)
        floatingButton.shakeHorizontaly()
    }

    // MARK: - Methods
    private func createUI() {
        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        activateTableViewConstraints()
        view.addSubview(floatingButton)
        activateFloatingButtonConstraints()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)
    }

    @objc private func didFloatingButtonTapped() {
        !isEditing ? pushNoteVC() : removeNotes()
    }

    private func pushNoteVC() {
        let noteVC = NoteViewController(note: Note())
        noteVC.noteDelegate = self
        navigationController?.pushViewController(noteVC, animated: true)
    }

    private func removeNotes() {
        table.performBatchUpdates {
            let indices = table.indexPathsForSelectedRows
            if indices == nil { showAlert() }

            indices?.forEach {
                notes.remove(at: $0.section)
                table.deleteSections([$0.section], with: .automatic)
            }
        }
    }

    private func showAlert() {
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
        switch isEditing {
        case true:
            if let cell = tableView.cellForRow(at: indexPath) as? NoteCell {
                cell.shake()
            }
        case false:
            let noteVC = NoteViewController(note: notes[indexPath.section])
            noteVC.noteDelegate = self

            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.6,
                options: []
            ) { [weak self] in
                guard let self = self else { return }
                self.floatingButton.bottomAnchor.constraint(
                    equalTo: self.view.topAnchor, constant: -30
                ).isActive = true
                self.view.layoutSubviews()
            } completion: { _ in
                self.navigationController?.pushViewController(noteVC, animated: true)
            }
        }
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

// MARK: - Constraints
extension ListViewController {
    private func activateTableViewConstraints() {
        table.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 16
        ).isActive = true
        table.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -16
        ).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func activateFloatingButtonConstraints() {
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20
        ).isActive = true
        floatingButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20
        ).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
