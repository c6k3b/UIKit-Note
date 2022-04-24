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
        view.backgroundColor = .systemBackground
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteCell.identifier,
            for: indexPath
        ) as? NoteCell else {
            return UITableViewCell()
        }
        cell.configure(with: notes[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteVC = NoteViewController(note: notes[indexPath.row])
        noteVC.noteDelegate = self
        navigationController?.pushViewController(noteVC, animated: true)
        notes.remove(at: indexPath.row)
    }
}

// MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

 extension ListViewController: NoteDelegate {
    func passDataToView(from note: Note) {
        notes.append(note)
        table.reloadData()
    }
 }
