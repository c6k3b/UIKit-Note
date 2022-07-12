enum NoteModel {
    enum SingleNote {
        struct Request {}
        struct Response {
            let note: Note
        }
        enum ViewModel {
            case success(note: NoteView.Model)
            case failure(alert: Alert)
        }
    }

    enum NoteSaving {
        struct Request {
            let note: NoteView.Model
        }
        struct Response {}
        enum ViewModel {}
    }
}

extension NoteModel.SingleNote.ViewModel {
    struct Alert {
        let title: String
        let message: String
        let actionTitle: String
    }
}
