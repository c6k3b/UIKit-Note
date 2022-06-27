import UIKit

final class NoteViewController: UIViewController, NoteDisplayLogic {
    // MARK: - Props
    private let interactor: NoteBusinessLogic
    let router: (NoteRoutingLogic & NoteDataPassing)

    var note = NoteView.Model(header: "", body: "", date: "")

    // MARK: - UI Components
    private let noteView = NoteView()

    private lazy var navigationLeftBarButton: UIBarButtonItem = {
        $0.image = Styles.NoteVC.backBtnImg
        $0.target = self
        $0.action = #selector(didNavigationLeftBarButtonTapped)
        return $0
    }(UIBarButtonItem())

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
    func displayNote(_ viewModel: NoteModel.SingleNote.ViewModel) {
        switch viewModel {
        case .success(note: let note):
            self.note = note
            setupUI()
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
        interactor.requestNote(NoteModel.SingleNote.Request())
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
        noteView.configure(with: note)
        navigationItem.leftBarButtonItem = navigationLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem
    }

    @objc private func didNavigationLeftBarButtonTapped() {
        router.route()
    }

    private func save() {
        let request = NoteModel.NoteSaving.Request(
            note: NoteView.Model(
                header: noteView.headerTextField.text ?? "",
                body: noteView.bodyTextView.text,
                date: ""
            )
        )
        interactor.saveNote(request)
    }
}
