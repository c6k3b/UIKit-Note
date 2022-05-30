import Foundation
import UIKit

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}

protocol ConfigurableNoteView {
    func configure(with model: NoteViewModel)
}

protocol WorkerType {
    func fetch(completion: ([NoteData]) -> Void)
}
