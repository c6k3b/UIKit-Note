import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func didMoveToSuperview() {
        activateActivityIndicatorViewConstraints()
    }

    // MARK: - Methods
    private func setupUI() {
        style = .medium
        startAnimating()
    }
}

// MARK: - Constraints
extension ActivityIndicator {
    private func activateActivityIndicatorViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }
}
