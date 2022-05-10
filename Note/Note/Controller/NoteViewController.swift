import UIKit

class NoteViewController: UIViewController {
    private let navigationLeftBarButton = UIBarButtonItem()
    private let headerTextField = UITextField()
    private let dateLabel = UILabel()
    private let bodyTextView = UITextView()
    private let stackView = UIStackView()

    private var note: Note
    private var isChanged = false

    weak var noteDelegate: NoteDelegate?

    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupStackView()

        view.backgroundColor = .systemBackground
        setEditing(true, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        headerTextField.isUserInteractionEnabled = isEditing
        bodyTextView.isUserInteractionEnabled = isEditing
        dateLabel.isUserInteractionEnabled = isEditing
        navigationLeftBarButton.isEnabled = !isEditing
        editButtonItem.title = isEditing ? "Готово" : "Изменить"

        if isEditing {
            bodyTextView.becomeFirstResponder()
        } else {
            saveNote()
            if isEmpty() {
                showAlert()
                setEditing(editing, animated: animated)
            }
            bodyTextView.resignFirstResponder()
        }
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8

        setupDateLabel()
        setupHeaderTextField()
        setupBodyTextView()

        view.addSubview(stackView)
        activateStackViewConstraints()
    }

    private func setupNavigation() {
        navigationLeftBarButton.image = UIImage(named: "backButton")
        navigationLeftBarButton.target = self
        navigationLeftBarButton.action = #selector(didNavigationLeftBarButtonTapped)
        navigationItem.leftBarButtonItem = navigationLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem
    }

    private func setupDateLabel() {
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .systemGray
        dateLabel.textAlignment = .center

        dateLabel.text = note.date.getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm")

        stackView.addArrangedSubview(dateLabel)
    }

    private func setupHeaderTextField() {
        headerTextField.placeholder = "Введите название"
        headerTextField.font = .systemFont(ofSize: 24, weight: .bold)

        headerTextField.text = note.header

        stackView.addArrangedSubview(headerTextField)
    }

    private func setupBodyTextView() {
        bodyTextView.font = .systemFont(ofSize: 16)
        bodyTextView.autocorrectionType = .no
        bodyTextView.adjustableKeyboard()

        bodyTextView.text = note.body

        stackView.addArrangedSubview(bodyTextView)
    }

    private func saveNote() {
        if headerTextField.text != note.header || bodyTextView.text != note.body {
            note.header = headerTextField.text
            note.body = bodyTextView.text
            note.date = Date()

            dateLabel.text = note.date.getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm")
            isChanged.toggle()
        }
    }

    private func showAlert() {
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

    @objc private func didNavigationLeftBarButtonTapped() {
        noteDelegate?.passData(from: note, isChanged: isChanged)
        navigationController?.popViewController(animated: true)
    }
}

extension NoteViewController {
    private func isEmpty() -> Bool {
        return note.isEmpty
    }
}

// MARK: - Constraints
extension NoteViewController {
    private func activateStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 8
        ).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -16
        ).isActive = true
    }
}
