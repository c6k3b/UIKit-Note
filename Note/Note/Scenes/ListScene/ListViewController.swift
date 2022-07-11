import UIKit

final class ListViewController: UIViewController, ListDisplayLogic {
    // MARK: - Props
    let interactor: ListBusinessLogic
    let router: (ListRoutingLogic & ListDataPassing)

    var notes: [NoteCell.Model] = []

    // MARK: - UI Components
    private let activityIndicator = ActivityIndicator(frame: .zero)

    lazy var table: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(NotesTableView())

    private lazy var floatingButton: FloatingButton = {
        $0.addTarget(self, action: #selector(didFloatingButtonTapped), for: .touchUpInside)
        return $0
    }(FloatingButton())

    // MARK: - Initializers
    init(interactor: ListBusinessLogic, router: ListRoutingLogic & ListDataPassing) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - DisplayLogic
    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel) {
        notes = viewModel.notes
        activityIndicator.stopAnimating()
        table.reloadData()
    }

    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel) {
        switch viewModel {
        case .success(indicesToRemove: let indices):
            indices.forEach { notes.remove(at: $0) }
            table.reloadData()
        case .failure(alert: let alert):
            showAlert(
                title: alert.title,
                message: alert.message,
                actionTitle: alert.actionTitle
            )
        }
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
        floatingButton.layer.opacity = 1
        showNotesList()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: true)

        editButtonItem.title = !table.isEditing
            ? Styles.ListVC.navBarEditBtnTitle
            : Styles.ListVC.navBarEditBtnTitleEditing

        floatingButton.setImage(
            !table.isEditing
                ? Styles.FloatingBtn.img
                : Styles.FloatingBtn.imgEditing,
            for: .normal
        )

        floatingButton.shakeHorizontaly()
    }

    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = Styles.ListVC.bgColor

        navigationItem.title = Styles.ListVC.navBarTitle
        editButtonItem.title = Styles.ListVC.navBarEditBtnTitle
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(table)
        view.addSubview(floatingButton)
        view.addSubview(activityIndicator)
    }

    @objc func didFloatingButtonTapped() {
        if isEditing {
            guard let indexPath = table.indexPathsForSelectedRows?.sorted(by: >) else {
                return remove(indices: nil, cells: nil)
            }
            let noteIndexesToRemove = indexPath.map { $0.section }
            let sectionsForRemove = IndexSet(noteIndexesToRemove)

            remove(indices: noteIndexesToRemove, cells: sectionsForRemove)
            isEditing = false
        } else {
            navigate()
        }
    }

    func showNotesList() {
        interactor.fetchNotes(ListModel.NotesList.Request())
    }

    func remove(indices: [Int]?, cells: IndexSet?) {
        if let cells = cells,
        let indices = indices {
            table.beginUpdates()
            interactor.performNotesRemoving(
                ListModel.NotesRemoving.Request(indicesToRemove: indices)
            )
            table.deleteSections(cells, with: .left)
            table.endUpdates()
        } else {
            interactor.performNotesRemoving(
                ListModel.NotesRemoving.Request(indicesToRemove: [])
            )
        }
    }

    func navigate() {
        table.isUserInteractionEnabled = false
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.router.route()
            self.table.isUserInteractionEnabled = true
        }
        floatingButton.shakeOnDisappear()
        UIView.animate(withDuration: 0.2, delay: 0.6, options: []) {
            self.floatingButton.layer.opacity = 0
        }
        CATransaction.commit()
    }
}
