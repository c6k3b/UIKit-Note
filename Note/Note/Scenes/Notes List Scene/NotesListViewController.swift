import UIKit

final class NotesListViewController: UIViewController, NotesListDisplayLogic {
    private let interactor: NotesListBusinessLogic
    private let router: NotesListRoutingLogic
    private lazy var notes: [Note] = []

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
//        $0.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        return $0
    }(FloatingButton())

    private let activityIndicator: UIActivityIndicatorView = {
        $0.startAnimating()
        $0.style = UIActivityIndicatorView.Style.medium
        return $0
    }(UIActivityIndicatorView())

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

    private func setupUI() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.97)

        navigationItem.title = "Заметки"
        editButtonItem.title = "Выбрать"
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        activateTableViewConstraints()

        view.addSubview(floatingButton)

        view.addSubview(activityIndicator)
        activateActivityIndicatorViewConstraints()
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

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if !isEditing { pushNoteVC(NoteViewController(note: notes[indexPath.section])) }
//    }
}

// MARK: - Constraints
extension NotesListViewController {
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

    private func activateActivityIndicatorViewConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
