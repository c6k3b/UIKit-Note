enum NoteModel {
    enum SingleNote {
        struct Request {}
        struct Response {
            let note: Note
        }
        enum ViewModel: Equatable {
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
    struct Alert: Equatable {
        let title: String
        let message: String
        let actionTitle: String
    }
}

extension NoteModel.SingleNote.ViewModel {
    static func == (lhs: NoteModel.SingleNote.ViewModel, rhs: NoteModel.SingleNote.ViewModel) -> Bool {
        switch (lhs, rhs) {
        case (let .success(note: lhs), let .success(note: rhs)):
            return lhs == rhs
        case (let .failure(alert: lhs), let .failure(alert: rhs)):
            return lhs == rhs
        default: return false
        }
    }
}
