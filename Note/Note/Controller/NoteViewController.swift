import UIKit

class NoteViewController: UIViewController {
    var note: Note!
    var noteDelegate: NoteDelegate!
    private var isEditingMode = false

    private let navigationRightBarButton = UIBarButtonItem()
    private let noteHeaderTextField = UITextField()
    private let noteDateLabel = UILabel()
    private let noteBodyTextView = UITextView()
    private let datePicker = UIDatePicker()

    private var dateLabelText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEEE HH:mm"
        return dateFormatter.string(from: note.date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupNavigationLeftBarButton()
        setupNavigationRightBarButton()
        setupNoteDateLabel()
        setupNoteHeaderTextField()
        setupNoteBodyTextView()
        didRightBarButtonTapped(navigationRightBarButton)
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        if parent == nil {   // back button was pressed
            noteDelegate?.passNote(note)
        }
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

    private func setupNavigationLeftBarButton() {
        if let topItem = self.navigationController?.navigationBar.topItem {
           topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }

    private func setupNavigationRightBarButton() {
        navigationRightBarButton.target = self
        navigationRightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = navigationRightBarButton
    }

    private func setupNoteDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 14)
        noteDateLabel.text = dateLabelText
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

    private func setupNoteHeaderTextField() {
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

    private func setupNoteBodyTextView() {
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
        note.date = datePicker.date
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
}

extension NoteViewController {
    private func isEmpty() -> Bool {
        return note.isEmpty
    }
}

extension UITextView {
    func adjustableKeyboard() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil
        )
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            contentInset = .zero
        } else {
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }

        scrollIndicatorInsets = contentInset
        scrollRangeToVisible(selectedRange)
    }
}
