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
        enum ViewModel: Equatable {
            case success(indicesToRemove: [Int])
            case failure(alert: Alert)
        }
    }
}

extension ListModel.NotesRemoving.ViewModel {
    struct Alert: Equatable {
        let title: String
        let message: String
        let actionTitle: String
    }
}

extension ListModel.NotesRemoving.ViewModel {
    static func == (lhs: ListModel.NotesRemoving.ViewModel, rhs: ListModel.NotesRemoving.ViewModel) -> Bool {
        switch (lhs, rhs) {
        case (let .success(indicesToRemove: lhs), let .success(indicesToRemove: rhs)):
            return lhs == rhs
        case (let .failure(alert: lhs), let .failure(alert: rhs)):
            return lhs == rhs
        default: return false
        }
    }
}
