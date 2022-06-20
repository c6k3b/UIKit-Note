import UIKit

class NoteView: UIView {
    // MARK: - Props
    private lazy var stackView: UIStackView = {
        $0.addArrangedSubview(dateLabel)
        $0.addArrangedSubview(headerTextField)
        $0.addArrangedSubview(bodyTextView)
        return $0
    }(NoteStackView())

    let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .systemGray
        $0.textAlignment = .center
        return $0
    }(UILabel())

    let headerTextField: UITextField = {
        $0.placeholder = "Введите название"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UITextField())

    let bodyTextView: UITextView = {
        $0.font = .systemFont(ofSize: 16)
        $0.autocorrectionType = .no
        $0.adjustableKeyboard()
        return $0
    }(UITextView())

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(stackView)
    }
}
