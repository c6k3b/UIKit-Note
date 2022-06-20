import UIKit

final class NoteViewController: UIViewController, NoteDisplayLogic {
    // MARK: - Props
    private lazy var navigationLeftBarButton: UIBarButtonItem = {
        $0.image = Styles.NoteVC.backBtnImg
        $0.target = self
        $0.action = #selector(didNavigationLeftBarButtonTapped)
        return $0
    }(UIBarButtonItem())

    private let noteView = NoteView()

    private let interactor: NoteBusinessLogic
    let router: (NoteRoutingLogic & NoteDataPassing)

    // MARK: - Initializers
    init(interactor: NoteBusinessLogic, router: NoteRoutingLogic & NoteDataPassing) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - DisplayLogic
    func displayNote(_ viewModel: NoteModel.PresentNote.ViewModel) {
        noteView.dateLabel.text = viewModel.date
        noteView.headerTextField.text = viewModel.header
        noteView.bodyTextView.text = viewModel.body
    }

    func displayEmptyFieldsAlert(_ viewModel: NoteModel.Alert.ViewModel) {
        showAlert(
            title: viewModel.title,
            message: viewModel.message,
            actionTitle: viewModel.actionTitle
        )
        isEditing.toggle()
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.displayNote(NoteModel.PresentNote.Request())
        setEditing(true, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        navigationLeftBarButton.isEnabled = !editing
        editButtonItem.title = !editing
            ? Styles.NoteVC.navBarEditBtnTitle
            : Styles.NoteVC.navBarEditBtnTitleEditing

        view.isUserInteractionEnabled = editing

        if editing {
            noteView.bodyTextView.becomeFirstResponder()
        } else {
            noteView.bodyTextView.resignFirstResponder()
            noteView.dateLabel.shake()
            save()
        }
    }

    // MARK: - Methods
    private func setupUI() {
        view = noteView
        navigationItem.leftBarButtonItem = navigationLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem
    }

    @objc private func didNavigationLeftBarButtonTapped() {
        router.route()
    }

    private func save() {
        let request = NoteModel.SaveNote.Request(
            header: noteView.headerTextField.text,
            body: noteView.bodyTextView.text
        )
        interactor.saveNote(request)
    }
}
