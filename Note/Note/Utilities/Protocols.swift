import Foundation

protocol NoteDelegate: AnyObject {
    func passNote(_ note: Note)
}

protocol ShowingNoteDelegate: AnyObject {
    func showNoteVC(for noteView: NoteView)
}
