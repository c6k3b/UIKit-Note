import UIKit

class NoteView: UIView, ConfigurableNoteView {
    // MARK: - Props
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
        return $0
    }(UILabel())

    private lazy var headerTextField: UITextField = {
        $0.placeholder = "Введите название"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UITextField())

    private lazy var bodyTextView: UITextView = {
        $0.font = .systemFont(ofSize: 16)
        $0.autocorrectionType = .no // Avoid constraints errors
        $0.adjustableKeyboard()
        return $0
    }(UITextView())

    var model: NoteViewModel?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(stackView)
        activateStackViewConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ viewModel: NoteViewModel) {
        model = viewModel
        dateLabel.text = model?.date
        headerTextField.text = model?.header
        bodyTextView.text = model?.body
    }
}

// MARK: - Constraints
extension NoteView {
    private func activateStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor, constant: 8
        ).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16
        ).isActive = true
    }
}
