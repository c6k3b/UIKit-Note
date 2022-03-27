import UIKit

class MainView: UIView {
    
    // MARK: - Props
    typealias View = Styles.View
    let textField = TextField()
    let textView = TextView()
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        setAppearance()
        addSubviews()
    }
    
    // MARK: - Methods
    private func setAppearance() {
        let lightColorScheme = traitCollection.userInterfaceStyle == .light
        
        backgroundColor = lightColorScheme ? View.backgroundLight : View.backgroundDark
    }
    
    private func addSubviews() {
        addSubview(textField)
        addSubview(textView)
    }
}
