enum ListModel {
    enum NotesList {
        struct Request {}
        struct Response {
            let notes: [Note]
        }
        struct ViewModel {
            let notes: [NoteCell.Model]
        }
    }

    enum NotesRemoving {
        struct Request {
            let indicesToRemove: [Int]
        }
        struct Response {
            let indicesToRemove: [Int]
        }
        enum ViewModel {
            case success(indicesToRemove: [Int])
            case failure(alert: Alert)
        }
    }

    enum SelectedNote {
        struct Request {
            let noteIndex: Int?
        }
        struct Response {
            let note: Note
        }
        struct ViewModel {}
    }
}

extension ListModel.NotesRemoving.ViewModel {
    struct Alert {
        let title: String
        let message: String
        let actionTitle: String
    }
}
