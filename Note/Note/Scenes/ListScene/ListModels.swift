import UIKit

enum ListModel {
    enum NotesList {
        struct Request {}
        struct Response {
            let notes: [Note]
        }
        struct ViewModel {
            let notes: [SingleNote.ViewModel]
        }
    }

    enum SingleNote {
        struct Request {}
        struct Response {
        }
        struct ViewModel {
            let header: String
            let body: String
            let date: String
            let icon: UIImage
        }
    }

    enum Alert {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let title: String
            let message: String
            let actionTitle: String
        }
    }
}
