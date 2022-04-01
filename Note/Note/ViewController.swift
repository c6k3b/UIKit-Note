import UIKit

class ViewController: UIViewController {
    private var rightBarButton = UIBarButtonItem()
    private var textField = UITextField()
    private var textView = UITextView()
    private var isEditingMode = false

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
            textView.resignFirstResponder()
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
            constant: 8
        ).isActive = true
    }

    private func setUserInteractionState() {
        textField.isUserInteractionEnabled = isEditingMode
        textView.isUserInteractionEnabled = isEditingMode
    }
}
