import UIKit

class NoteViewController: UIViewController {
    // MARK: - Props
    private lazy var navigationLeftBarButton: UIBarButtonItem = {
        $0.image = UIImage(named: "backButton")
        $0.target = self
        $0.action = #selector(didNavigationLeftBarButtonTapped)
        return $0
    }(UIBarButtonItem())

    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 8
        $0.addArrangedSubview(dateLabel)
        $0.addArrangedSubview(headerTextField)
        $0.addArrangedSubview(bodyTextView)
        return $0
    }(UIStackView())

    private lazy var dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
        $0.textAlignment = .center
        $0.text = setupDateLabel()
        return $0
    }(UILabel())

    private lazy var headerTextField: UITextField = {
        $0.placeholder = "Введите название"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = note.header
        return $0
    }(UITextField())

    private lazy var bodyTextView: UITextView = {
        $0.font = .systemFont(ofSize: 16)
        $0.autocorrectionType = .no
        $0.adjustableKeyboard()
        $0.text = note.body
        return $0
    }(UITextView())

    private lazy var isChanged: Bool = {
        headerTextField.text != note.header || bodyTextView.text != note.body
    }()

    private var note: Note
    weak var noteDelegate: NoteDelegate?

    // MARK: - Lifecycle
    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
        setEditing(true, animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        dateLabel.isUserInteractionEnabled = editing
        headerTextField.isUserInteractionEnabled = editing
        bodyTextView.isUserInteractionEnabled = editing

        navigationLeftBarButton.isEnabled = !editing
        editButtonItem.title = editing ? "Готово" : "Изменить"

        _ = editing ? bodyTextView.becomeFirstResponder() :  bodyTextView.resignFirstResponder()

        if !editing && isChanged {
            saveNote()
            dateLabel.text = setupDateLabel()
            dateLabel.shake()
        }

        if !editing && isEmpty() {
            showEmptyFieldsAlert()
            setEditing(!editing, animated: true)
        }
    }

    // MARK: - Methods
    private func createUI() {
        view.backgroundColor = .systemBackground

        navigationItem.leftBarButtonItem = navigationLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem

        view.addSubview(stackView)
        activateStackViewConstraints()
    }

    private func setupDateLabel() -> String {
        note.date.getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm")
    }

    @objc private func didNavigationLeftBarButtonTapped() {
        noteDelegate?.passData(from: note, isChanged: isChanged)
        navigationController?.popViewController(animated: true)
    }

    private func saveNote() {
        note.header = headerTextField.text
        note.body = bodyTextView.text
        note.date = Date()
    }
}

extension NoteViewController {
    private func isEmpty() -> Bool {
        return note.isEmpty
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

// MARK: - Constraints
extension NoteViewController {
    private func activateStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8
        ).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16
        ).isActive = true
    }
}
