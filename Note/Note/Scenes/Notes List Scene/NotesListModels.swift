import Foundation
import UIKit

enum NotesListModels {
    enum InitForm {
        struct Request {
            let note: Note
        }

        struct Response {
            let notes: [Note]
        }

        struct ViewModel {
            let header: String?
            let body: String?
            let date: String
            let icon: UIImage?
        }
    }
}
