enum NoteModel {
    enum SingleNote {
        struct Request {}
        struct Response {
            let note: Note
        }
        struct ViewModel {
            let date: String
            let header: String
            let body: String
        }
    }

    enum NoteSaving {
        struct Request {
            let header: String?
            let body: String?
        }
        struct Response {
            let note: Note
        }
        struct ViewModel {}
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
