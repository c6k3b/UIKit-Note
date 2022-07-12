import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    // MARK: - Lifecycle
    override func didMoveToSuperview() {
        setupUI()
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
