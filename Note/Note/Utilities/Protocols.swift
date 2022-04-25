import Foundation

protocol NoteDelegate: AnyObject {
//    private var isChanged: Bool { get set }
    func passData(from note: Note, isChanged: Bool)
}

protocol ConfigurableCell {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
