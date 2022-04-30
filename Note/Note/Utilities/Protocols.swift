import Foundation
import UIKit

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}

protocol ConfigurableCell {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
