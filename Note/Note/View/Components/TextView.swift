import UIKit

class TextView: UITextView {
    
    // MARK: - Props
    typealias View = Styles.TextView
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        setAppearance()
        activateCurrentConstraints()
    }
    
    // MARK: - Methods
    private func setAppearance() {
        let isLightColorScheme = traitCollection.userInterfaceStyle == .light
        
        font = View.font
        
        backgroundColor = isLightColorScheme ? View.backgroundColorLight : View.backgroundColorDark
        layer.borderWidth = View.borderWidth
        layer.borderColor = isLightColorScheme ? View.borderColorLight : View.borderColorDark
        layer.cornerRadius = View.cornerRadius
        
        textContainer.lineFragmentPadding = View.textPadding
    }
    
    private func activateCurrentConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: View.topAnchor),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: View.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: View.trailingAnchor),
                heightAnchor.constraint(equalToConstant: View.heightAnchor)
            ])
        }
    }
}
