import UIKit

class FloatingButton: UIButton {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func didMoveToSuperview() {
        activateFloatingButtonConstraints()
    }

    // MARK: - Methods
    private func createUI() {
        layer.cornerRadius = 25
        clipsToBounds = true
        contentVerticalAlignment = .bottom
        titleLabel?.font = .systemFont(ofSize: 36)
        setImage(UIImage(named: "buttonPlus"), for: .normal)
    }
}

// MARK: - Constraints
extension FloatingButton {
    private func activateFloatingButtonConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            trailingAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -20
            ).isActive = true
            bottomAnchor.constraint(
                equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -20
            ).isActive = true
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
}
