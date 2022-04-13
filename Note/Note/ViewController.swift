import UIKit

class ViewController: UIViewController {
    private var note = Note()
    private var isEditingMode = false

    private let navigationRightBarButton = UIBarButtonItem()
    private let noteHeaderTextField = UITextField()
    private let noteDateLabel = UILabel()
    private let noteBodyTextView = UITextView()
    private let datePicker = UIDatePicker()

    private var dateLabelText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        return "Дата: \(dateFormatter.string(from: note.date))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметка"
        view.backgroundColor = .systemBackground

        setupNavigationRightBarButton()
        setupNoteHeaderTextField()
        setupNoteDateLabel()
        setupNoteBodyTextView()
        didRightBarButtonTapped(navigationRightBarButton)
    }

    @objc
    private func didRightBarButtonTapped(_ button: UIBarButtonItem) {
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

    private func setupNavigationRightBarButton() {
        navigationRightBarButton.title = "Изменить"
        navigationRightBarButton.target = self
        navigationRightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = navigationRightBarButton
    }

    private func setupNoteHeaderTextField() {
        noteHeaderTextField.placeholder = "Заголовок"
        noteHeaderTextField.font = .systemFont(ofSize: 22, weight: .bold)

        noteHeaderTextField.text = note.header

        view.addSubview(noteHeaderTextField)

        noteHeaderTextField.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderTextField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
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

    private func setupNoteDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 14)
        noteDateLabel.text = dateLabelText

        let gesture = UITapGestureRecognizer(target: self, action: #selector(showDatePickerAlert))
        noteDateLabel.addGestureRecognizer(gesture)

        view.addSubview(noteDateLabel)

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(
            equalTo: noteHeaderTextField.bottomAnchor,
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

    private func setupNoteBodyTextView() {
        noteBodyTextView.font = .systemFont(ofSize: 14)
        noteBodyTextView.text = note.body

        view.addSubview(noteBodyTextView)

        noteBodyTextView.translatesAutoresizingMaskIntoConstraints = false
        noteBodyTextView.topAnchor.constraint(
            equalTo: noteDateLabel.bottomAnchor,
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

    private func setupDatePicker() {
        datePicker.frame.origin = CGPoint(x: 0, y: -20)
        datePicker.datePickerMode = .date
        datePicker.locale = .autoupdatingCurrent

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
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

    @objc
    private func showDatePickerAlert() {
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        setupDatePicker()

        alert.view.addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true

        alert.addAction(UIAlertAction(title: "Выбрать", style: .default) { _ in
            self.note.date = self.datePicker.date
            self.noteDateLabel.text = self.dateLabelText
        })

        present(alert, animated: true)
    }
}

extension ViewController {
    private func isEmpty() -> Bool {
        return note.isEmpty
    }
}
