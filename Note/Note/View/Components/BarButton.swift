import UIKit

class BarButton: UIBarButtonItem {
    
    override init() {
        super.init()
        title = "Change"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
