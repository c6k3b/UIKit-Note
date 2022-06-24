enum ListModel {
    enum NotesList {
        struct Request {}
        struct Response {
            let notes: [Note]
        }
        struct ViewModel {
            let notes: [NoteCell.NoteViewModel]
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
