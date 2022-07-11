import UIKit

class FloatingButton: UIButton {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle
    override func didMoveToSuperview() {
        activateFloatingButtonConstraints()
    }

    // MARK: - Methods
    private func setupUI() {
        layer.cornerRadius = Styles.FloatingBtn.cornerRadius
        clipsToBounds = true
        contentVerticalAlignment = .bottom
        titleLabel?.font = Styles.FloatingBtn.font
        setImage(Styles.FloatingBtn.img, for: .normal)
    }
}

// MARK: - Constraints
extension FloatingButton {
    private func activateFloatingButtonConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            trailingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                constant: Styles.FloatingBtn.trailingConstraint
            ).isActive = true
            bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                constant: Styles.FloatingBtn.bottomConstraint
            ).isActive = true
            heightAnchor.constraint(
                equalToConstant: Styles.FloatingBtn.height
            ).isActive = true
            widthAnchor.constraint(
                equalToConstant: Styles.FloatingBtn.width
            ).isActive = true
        }
    }
}
