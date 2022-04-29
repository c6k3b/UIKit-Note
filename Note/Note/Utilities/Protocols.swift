import Foundation

protocol NoteDelegate: AnyObject {
    func passDataToView(from note: Note)
}
