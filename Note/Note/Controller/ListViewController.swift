import UIKit

class ListViewController: UIViewController {
    private let navigationRightBarButton = UIBarButtonItem()
    private let floatingButton = FloatingButton()
    private let tableView = UITableView()

    private var notes = SampleData().notes
    private var isEditingMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        setupNavigation()
        addSubviews()
        setupFloatingButton()
        registerCell()
        setupDelegates()
    }

    private func setAppearance() {
        view.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }

    private func setupNavigation() {
        navigationItem.title = "Заметки"

        setupNavigationRightButtonTitle()
        navigationRightBarButton.target = self
        navigationRightBarButton.action = #selector(didNavigationRightBarButtonTapped)
        navigationItem.rightBarButtonItem = navigationRightBarButton
    }

    private func setupNavigationRightButtonTitle() {
        navigationRightBarButton.title = !isEditingMode ? "Выбрать" : "Готово"
    }

    private func addSubviews() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupFloatingButton() {
        floatingButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        view.addSubview(floatingButton)
    }

    private func registerCell() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
    }

    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    @objc private func didNavigationRightBarButtonTapped() {
        isEditingMode.toggle()
        setupNavigationRightButtonTitle()

        notes.forEach { $0.isEditingMode = isEditingMode }
        tableView.reloadData()

        floatingButton.isEditingMode = isEditingMode
        floatingButton.layoutSubviews()
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
    }
}

// MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
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
    func passData(from note: Note, isChanged: Bool) {
        if isChanged {
            if let index = notes.firstIndex(where: { $0 === note }) {
                notes[index] = note
            } else {
                notes.append(note)
            }
        }
        tableView.reloadData()
    }
 }
