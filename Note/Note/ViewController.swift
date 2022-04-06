import UIKit

class ViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var textField = UITextField()
    private var textView = UITextView()
    private var isEditingMode = false
    private var note = Note()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметка"
        view.backgroundColor = .systemBackground

        setupRightBarButton()
        setupTextField()
        setupTextView()
        didRightBarButtonTapped(rightBarButton)
    }

    @objc
    private func didRightBarButtonTapped(_ button: UIBarButtonItem) {
        isEditingMode = !isEditingMode
        setUserInteractionState()

        if isEditingMode {
            rightBarButton.title = "Готово"
            textView.becomeFirstResponder()
        } else {
            rightBarButton.title = "Изменить"
            saveNote()

            if isEmpty() {
                showAlert()
                didRightBarButtonTapped(rightBarButton)
            } else {
                textView.resignFirstResponder()
            }
        }
    }

    private func setupRightBarButton() {
        rightBarButton.title = "Изменить"
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setupTextField() {
        textField.placeholder = "Title"
        textField.font = .systemFont(ofSize: 22, weight: .bold)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)

        textField.text = note.header

        view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 8
        ).isActive = true
        textField.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        textField.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupTextView() {
        textView.textContainer.lineFragmentPadding = 8
        textView.font = .systemFont(ofSize: 14)

        textView.text = note.body

        view.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(
            equalTo: textField.bottomAnchor,
            constant: 8
        ).isActive = true
        textView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        textView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
        textView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -16
        ).isActive = true
    }

    private func setUserInteractionState() {
        textField.isUserInteractionEnabled = isEditingMode
        textView.isUserInteractionEnabled = isEditingMode
    }

    private func saveNote() {
        note.header = textField.text
        note.body = textView.text
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "Не все поля заполнены",
            message: "Не могу сохранить пустую заметку",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive))
        present(alert, animated: true)
    }
}

extension ViewController {
    private func isEmpty() -> Bool {
        print(note.header)
        print(note.body)
        print(note.isEmpty)
        return note.isEmpty
    }
}
