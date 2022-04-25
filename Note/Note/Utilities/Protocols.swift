import Foundation

protocol NoteDelegate: AnyObject {
    func passData(from note: Note)
}

protocol ConfigurableCell {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
