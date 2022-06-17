import UIKit

final class NoteViewController: UIViewController, NoteDisplayLogic {
    // MARK: - Props
    private lazy var navigationLeftBarButton: UIBarButtonItem = {
        $0.image = UIImage(named: "backButton")
        $0.target = self
        $0.action = #selector(didNavigationLeftBarButtonTapped)
        return $0
    }(UIBarButtonItem())

    private lazy var stackView: UIStackView = {
        $0.addArrangedSubview(dateLabel)
        $0.addArrangedSubview(headerTextField)
        $0.addArrangedSubview(bodyTextView)
        return $0
    }(NoteStackView())

    private let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let headerTextField: UITextField = {
        $0.placeholder = "Введите название"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UITextField())

    private let bodyTextView: UITextView = {
        $0.font = .systemFont(ofSize: 16)
        $0.autocorrectionType = .no
        $0.adjustableKeyboard()
        return $0
    }(UITextView())

    private let interactor: NoteBusinessLogic
    let router: (NoteRoutingLogic & NoteDataPassing)
//    private var note: NoteModel.ViewModel

    // MARK: - Initializers
    init(interactor: NoteBusinessLogic, router: NoteRoutingLogic & NoteDataPassing) {
        self.interactor = interactor
        self.router = router
//        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - DisplayLogic
    func displayNote(_ viewModel: NoteModel.ViewModel) {
        dateLabel.text = viewModel.date
        headerTextField.text = viewModel.header
        bodyTextView.text = viewModel.body
    }

    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.requestNote(NoteModel.Request())
        setEditing(true, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        navigationLeftBarButton.isEnabled = !editing
        editButtonItem.title = editing ? "Готово" : "Изменить"

        view.isUserInteractionEnabled = editing
        _ = editing ? bodyTextView.becomeFirstResponder() :  bodyTextView.resignFirstResponder()

        if !editing {
//            dateLabel.text = note.date.getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm")
            dateLabel.shake()
        }

        if !editing && isEmpty() {
            showEmptyFieldsAlert()
            setEditing(!editing, animated: true)
        }
    }

    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground

        navigationItem.leftBarButtonItem = navigationLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(stackView)
    }

    @objc private func didNavigationLeftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension NoteViewController {
    private func isEmpty() -> Bool {
        false
//        note.header.isEmpty && note.body.isEmpty
    }
}

// MARK: - Alerts
extension NoteViewController {
    private func showEmptyFieldsAlert() {
        let alert = UIAlertController(
            title: "Поля не заполнены",
            message: "Не могу сохранить пустую заметку",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Редактировать", style: .cancel) { _ in
            self.bodyTextView.becomeFirstResponder()
        }

        alert.addAction(action)
        present(alert, animated: true)
    }
}
