import UIKit

class MainView: UIView {
    
    // MARK: - Props
    typealias View = Styles.View
    
    var textField = TextField()
    var textView = TextView()
    let rightBarButton = BarButton()
    
    private var isEditingMode = false
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        addSubviews()
    }
    
    override func didMoveToSuperview() {
        setAppearance()
        didRightBarButtonTapped(rightBarButton)
    }
    
    // MARK: - Methods
    private func setAppearance() {
        
        let isLightColorScheme = traitCollection.userInterfaceStyle == .light
        
        backgroundColor = isLightColorScheme ? View.backgroundLight : View.backgroundDark
        
        rightBarButton.target = self
        rightBarButton.action = #selector(didRightBarButtonTapped(_:))
        
        setUserInteractionState()
    }
    
    private func addSubviews() {
        addSubview(textField)
        addSubview(textView)
    }
    
    private func setUserInteractionState() {
        textField.isUserInteractionEnabled = isEditingMode
        textView.isUserInteractionEnabled = isEditingMode
    }
    
    @objc
    private func didRightBarButtonTapped(_ button: UIBarButtonItem) {

        isEditingMode = !isEditingMode
        setUserInteractionState()

        if isEditingMode {
            rightBarButton.title = "Done"
            textView.becomeFirstResponder()
        } else {
            rightBarButton.title = "Change"
            textView.resignFirstResponder()
        }
    }
}
