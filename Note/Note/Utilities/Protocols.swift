import Foundation

protocol NoteDelegate: AnyObject {
    func passDataToView(from note: Note)
}

protocol ConfigurableCell {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
