import Foundation

protocol NewNoteDelegate: AnyObject {
    func createNewNoteView(from note: Note)
}

protocol NoteDelegate: AnyObject {
    func changeNoteModel(with note: Note)
}
