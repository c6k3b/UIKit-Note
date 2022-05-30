import Foundation
import UIKit

protocol NoteDelegate: AnyObject {
    func passData(from note: Note, isChanged: Bool)
}

protocol ConfigurableCell {
    func configure(header: String?, body: String?, date: String, icon: UIImage?)
}

protocol WorkerType {
    func fetch(completion: ([NoteData]) -> Void)
    func loadImage(from: String, completion: (Data) -> Void)
}
