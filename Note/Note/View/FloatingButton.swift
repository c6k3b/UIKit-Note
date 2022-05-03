import UIKit

class FloatingButton: UIButton {
    var isEditingMode = false

    override func layoutSubviews() {
        super.layoutSubviews()
        setAppearance()
        activateCurrentConstraints()
        shake()
    }

    private func setAppearance() {
        layer.cornerRadius = 25
        clipsToBounds = true
        contentVerticalAlignment = .bottom
        titleLabel?.font = .systemFont(ofSize: 36)
        backgroundColor = .systemBlue
        setImage(UIImage(named: !isEditingMode ? "buttonPlus" : "buttonTrash"), for: .normal)
    }

    private func activateCurrentConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                trailingAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                    constant: -20
                ),
                bottomAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                    constant: -20
                ),
                heightAnchor.constraint(equalToConstant: 50),
                widthAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
}
