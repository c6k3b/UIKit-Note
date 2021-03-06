import UIKit

class NoteStackView: UIStackView {
    // MARK: - Initializers
    override func didMoveToSuperview() {
        setupUI()
        activateStackViewConstraints()
    }

    // MARK: - Methods
    private func setupUI() {
        axis = .vertical
        distribution = .fill
        spacing = Styles.NoteStackView.spacing
    }
}

// MARK: - Constraints
extension NoteStackView {
    private func activateStackViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.leadingAnchor,
                constant: Styles.NoteStackView.leadingConstraint
            ).isActive = true
            trailingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                constant: Styles.NoteStackView.trailingConstraint
            ).isActive = true
            topAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.topAnchor,
                constant: Styles.NoteStackView.topConstraint
            ).isActive = true
            bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                constant: Styles.NoteStackView.bottomConstraint
            ).isActive = true
        }
    }
}
