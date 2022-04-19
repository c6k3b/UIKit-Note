import UIKit

class NoteViewController: UIViewController {
    private var note: Note

    private let navigationRightBarButton = UIBarButtonItem()
    private let noteHeaderTextField = UITextField()
    private let noteDateLabel = UILabel()
    private let noteBodyTextView = UITextView()

    private var isEditingMode = false
    private let didFinishNote: (Note) -> Void = { _ in }

    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupNavigation()
        setupDateLabel()
        setupHeaderTextField()
        setupBodyTextView()
        didRightBarButtonTapped(navigationRightBarButton)
    }

    private func setupNavigation() {
        if let topItem = self.navigationController?.navigationBar.topItem {
           topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }

        navigationRightBarButton.target = self
        navigationRightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = navigationRightBarButton
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        if parent == nil {   // back button was pressed
            didFinishNote(note)
        }
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

    private func setUserInteractionState() {
        noteHeaderTextField.isUserInteractionEnabled = isEditingMode
        noteBodyTextView.isUserInteractionEnabled = isEditingMode
        noteDateLabel.isUserInteractionEnabled = isEditingMode
    }

    private func saveNote() {
        note.header = noteHeaderTextField.text
        note.body = noteBodyTextView.text
        note.date = note.date
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

    @objc private func didRightBarButtonTapped(_ button: UIBarButtonItem) {
        isEditingMode = !isEditingMode
        setUserInteractionState()

        if isEditingMode {
            navigationRightBarButton.title = "Готово"
            noteBodyTextView.becomeFirstResponder()
        } else {
            navigationRightBarButton.title = "Изменить"
            saveNote()

            if isEmpty() {
                showAlert()
                didRightBarButtonTapped(navigationRightBarButton)
            }
            noteBodyTextView.resignFirstResponder()
        }
    }
}

extension NoteViewController {
    private func isEmpty() -> Bool {
        return note.isEmpty
    }
}
