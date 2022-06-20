import UIKit

final class ListViewController: UIViewController, ListDisplayLogic {
    // MARK: - Props
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

    private let interactor: ListBusinessLogic
    let router: (ListRoutingLogic & ListDataPassing)
    var notes: [ListModel.PresentList.ViewModel.PresentedNote] = []

    // MARK: - Initializers
    init(interactor: ListBusinessLogic, router: ListRoutingLogic & ListDataPassing) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - DisplayLogic
    func displayNotes(_ viewModel: ListModel.PresentList.ViewModel) {
        notes = viewModel.presentedCells
        self.activityIndicator.stopAnimating()
        self.table.reloadData()
    }

    func displayNoSelectionAlert(_ viewModel: ListModel.Alert.ViewModel) {
        showAlert(
            title: viewModel.title,
            message: viewModel.message,
            actionTitle: viewModel.actionTitle
        )
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.request(ListModel.PresentList.Request())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingButton.shakeOnAppear()
        floatingButton.layer.opacity = 1
        self.interactor.update()
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

    @objc private func didFloatingButtonTapped() {
        if isEditing {
            guard let indexPath = table.indexPathsForSelectedRows?.sorted(by: >) else {
                return interactor.showNoSelectionAlert()
            }
            let noteIndexesToRemove = indexPath.map { $0.section }
            let sectionsForRemove = IndexSet(noteIndexesToRemove)

            remove(indices: noteIndexesToRemove, cells: sectionsForRemove)
            isEditing = false
        } else {
            navigate()
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

    func remove(indices: [Int], cells: IndexSet) {
        table.beginUpdates()
        interactor.remove(indices)
        table.deleteSections(cells, with: .left)
        table.endUpdates()
    }

    func passSelectedNoteIndex(_ index: Int?) {
        interactor.getSelectedNoteIndex(index)
    }
}
