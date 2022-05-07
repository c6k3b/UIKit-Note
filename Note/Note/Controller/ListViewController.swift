import UIKit

class ListViewController: UIViewController {
    private var notes = SampleData().notes

    private let button = FloatingButton()
    private let table = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        addSubviews()
        registerCell()
        setupDelegates()
        setupButton()
    }

    private func setAppearance() {
        navigationItem.title = "Заметки"
        view.backgroundColor = .systemBackground.withAlphaComponent(0.98)
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.estimatedRowHeight = 90
    }

    private func addSubviews() {
        view.addSubview(table)

        table.translatesAutoresizingMaskIntoConstraints = false
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func registerCell() {
        table.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
    }

    private func setupDelegates() {
        table.dataSource = self
        table.delegate = self
    }

    private func setupButton() {
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func didButtonTapped() {
        let noteVC = NoteViewController(note: Note())
        noteVC.noteDelegate = self
        navigationController?.pushViewController(noteVC, animated: true)
    }
}

// MARK: - Datasource
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        notes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController(note: notes[indexPath.section])
        noteVC.noteDelegate = self
        navigationController?.pushViewController(noteVC, animated: true)
    }
}

// MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        4
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .fade)
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
