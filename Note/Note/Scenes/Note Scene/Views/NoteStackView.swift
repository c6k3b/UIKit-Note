import UIKit

class NoteStackView: UIStackView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        activateStackViewConstraints()
    }

    // MARK: - Methods
    private func setupUI() {
        axis = .vertical
        distribution = .fill
        spacing = 8
    }
}

// MARK: - Constraints
extension NoteStackView {
    private func activateStackViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            topAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 8
            ).isActive = true
            leadingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 16
            ).isActive = true
            trailingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -16
            ).isActive = true
            bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -16
            ).isActive = true
        }
    }
}
