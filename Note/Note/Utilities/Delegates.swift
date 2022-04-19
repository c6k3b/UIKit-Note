import Foundation

protocol NoteDelegate: AnyObject {
    func passNote(_ noteModel: NoteView.Model)
}
