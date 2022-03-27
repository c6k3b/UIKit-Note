import UIKit

enum Styles {
    
    // MARK: - Helpers
    enum Colors {
        static let whiteColor = UIColor(hex: 0xffffff)
        static let blackColor = UIColor(hex: 0x000000)
    }
    
    enum Spacing {
        static let size = 16.0
    }
    
    // MARK: - Navigation
    enum Navigation {
//        static let titleFont = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    // MARK: - Views
    enum View {
        static let backgroundLight = Colors.whiteColor
        static let backgroundDark = Colors.blackColor
    }
    
    enum TextField {
        static let font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    enum TextView {
        static let font = UIFont.systemFont(ofSize: 14)
    }
}
