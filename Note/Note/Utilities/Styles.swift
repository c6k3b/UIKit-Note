import UIKit

enum Styles {
    
    // MARK: - Helpers
    enum Colors {
        static let light = UIColor(hex: 0xfa_fa_fa)
        static let dark = UIColor(hex: 0x15_15_15)
        static let lightGray = UIColor(hex: 0xf6_f6_f6)
        static let darkGray = UIColor(hex: 0x2a_2a_2a)
    }
    
    enum Spacing {
        static let size = 16.0
    }
    
    // MARK: - Navigation
    enum Navigation {
        static let titleFont = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    // MARK: - Views
    enum View {
        static let backgroundLight = Colors.light
        static let backgroundDark = Colors.dark
    }
    
    enum TextField {
        static let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let topAnchor = Spacing.size
        static let leadingAnchor = Spacing.size
        static let trailingAnchor = -Spacing.size
        static let heightAnchor = Spacing.size * 3
        
        static let backgroundColorLight = Colors.lightGray
        static let backgroundColorDark = Colors.darkGray
        
        static let cornerRadius = Spacing.size / 2
        static let borderWidth = Spacing.size / 16
        static let borderColorLight = Colors.light.cgColor
        static let borderColorDark = Colors.dark.cgColor
        
        static let textPadding = Spacing.size / 2
    }
    
    enum TextView {
        static let font = UIFont.systemFont(ofSize: 14)
        static let topAnchor = Spacing.size * 6
        static let leadingAnchor = Spacing.size
        static let trailingAnchor = -Spacing.size
        static let heightAnchor = Spacing.size * 10
        
        static let backgroundColorLight = Colors.lightGray
        static let backgroundColorDark = Colors.darkGray
        
        static let cornerRadius = Spacing.size / 2
        static let borderWidth = Spacing.size / 16
        static let borderColorLight = Colors.light.cgColor
        static let borderColorDark = Colors.dark.cgColor
        
        static let textPadding = Spacing.size / 2
    }
}
