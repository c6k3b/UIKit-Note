import UIKit

class TextField: UITextField {
    
    // MARK: - Props
    typealias Field = Styles.TextField
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setAppearance()
        activateCurrentConstraints()
    }
    
    // MARK: - Methods
    private func setAppearance() {
        let isLightColorScheme = traitCollection.userInterfaceStyle == .light
        font = Field.font
        placeholder = "Title"
        backgroundColor = isLightColorScheme ? Field.backgroundColorLight : Field.backgroundColorDark

        layer.masksToBounds = true
        layer.borderWidth = Field.borderWidth
        layer.cornerRadius = Field.cornerRadius
        layer.borderColor = isLightColorScheme ? Field.borderColorLight : Field.borderColorDark
        
        layer.sublayerTransform = CATransform3DMakeTranslation(Field.textPadding, 0, 0)
    }
    
    private func activateCurrentConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: Field.topAnchor),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: Field.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: Field.trailingAnchor),
                heightAnchor.constraint(equalToConstant: Field.heightAnchor)
            ])
        }
    }
}
