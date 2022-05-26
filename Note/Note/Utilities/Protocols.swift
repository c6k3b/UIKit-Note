import Foundation
import UIKit

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}

protocol ConfigurableCell {
    func configure(header: String?, body: String?, date: String)
}

protocol WorkerType {
    func fetch(completion: (Data) -> Void)
}

protocol DecoderType {
    func decode(_ data: Data, completion: ([NoteData]) -> Void)
}
