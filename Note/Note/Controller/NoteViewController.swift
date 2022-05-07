import UIKit

class NoteViewController: UIViewController {
    private let navigationLeftBarButton = UIBarButtonItem()
    private let noteHeaderTextField = UITextField()
    private let noteDateLabel = UILabel()
    private let noteBodyTextView = UITextView()

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
        setupDateLabel()
        setupHeaderTextField()
        setupBodyTextView()

        view.backgroundColor = .systemBackground
        setEditing(true, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        noteHeaderTextField.isUserInteractionEnabled = isEditing
        noteBodyTextView.isUserInteractionEnabled = isEditing
        noteDateLabel.isUserInteractionEnabled = isEditing
        navigationLeftBarButton.isEnabled = !isEditing
        editButtonItem.title = isEditing ? "Готово" : "Изменить"

        if isEditing {
            noteBodyTextView.becomeFirstResponder()
        } else {
            saveNote()
            if isEmpty() {
                showAlert()
                setEditing(editing, animated: true)
            }
            noteBodyTextView.resignFirstResponder()
        }
    }

    private func setupNavigation() {
        navigationLeftBarButton.image = UIImage(named: "backButton")
        navigationLeftBarButton.target = self
        navigationLeftBarButton.action = #selector(didNavigationLeftBarButtonTapped)
        navigationItem.leftBarButtonItem = navigationLeftBarButton
        navigationItem.rightBarButtonItem = editButtonItem
    }

    private func setupDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 14)
        noteDateLabel.text = note.date.getFormattedDate(format: "dd.MM.yyyy EEEE HH:mm")
        noteDateLabel.textColor = .systemGray
        noteDateLabel.textAlignment = .center

        view.addSubview(noteDateLabel)

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 8
        ).isActive = true
        noteDateLabel.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteDateLabel.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupHeaderTextField() {
        noteHeaderTextField.placeholder = "Введите название"
        noteHeaderTextField.font = .systemFont(ofSize: 24, weight: .bold)

        noteHeaderTextField.text = note.header

        view.addSubview(noteHeaderTextField)

        noteHeaderTextField.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderTextField.topAnchor.constraint(
            equalTo: noteDateLabel.bottomAnchor,
            constant: 8
        ).isActive = true
        noteHeaderTextField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteHeaderTextField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupBodyTextView() {
        noteBodyTextView.font = .systemFont(ofSize: 16)
        noteBodyTextView.text = note.body
        noteBodyTextView.autocorrectionType = .no
        noteBodyTextView.adjustableKeyboard()

        view.addSubview(noteBodyTextView)

        noteBodyTextView.translatesAutoresizingMaskIntoConstraints = false
        noteBodyTextView.topAnchor.constraint(
            equalTo: noteHeaderTextField.bottomAnchor,
            constant: 8
        ).isActive = true
        noteBodyTextView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteBodyTextView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        noteBodyTextView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -16
        ).isActive = true
    }

    private func saveNote() {
        if noteHeaderTextField.text != note.header || noteBodyTextView.text != note.body {
            note.header = noteHeaderTextField.text
            note.body = noteBodyTextView.text
            note.date = Date()

            setupDateLabel()
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
            self.noteBodyTextView.becomeFirstResponder()
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
