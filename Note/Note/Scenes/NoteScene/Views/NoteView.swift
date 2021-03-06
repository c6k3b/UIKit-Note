import UIKit

class NoteView: UIView, ConfigurableView {
    // MARK: - UI Components
    private lazy var stackView: UIStackView = {
        $0.addArrangedSubview(dateLabel)
        $0.addArrangedSubview(headerTextField)
        $0.addArrangedSubview(bodyTextView)
        return $0
    }(NoteStackView())

    let dateLabel: UILabel = {
        $0.font = Styles.NoteView.dateFont
        $0.textColor = Styles.NoteView.dateFontColor
        $0.textAlignment = .center
        return $0
    }(UILabel())

    let headerTextField: UITextField = {
        $0.placeholder = Styles.NoteView.placeholder
        $0.font = Styles.NoteView.headerFont
        return $0
    }(UITextField())

    let bodyTextView: UITextView = {
        $0.font = Styles.NoteView.bodyFont
        $0.autocorrectionType = .no
        $0.adjustableKeyboard()
        return $0
    }(UITextView())

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    func configure(with model: NoteView.Model) {
        dateLabel.text = model.date
        headerTextField.text = model.header
        bodyTextView.text = model.body
    }

    // MARK: - Methods
    private func setupUI() {
        backgroundColor = Styles.NoteView.bgColor
        addSubview(stackView)
    }
}
