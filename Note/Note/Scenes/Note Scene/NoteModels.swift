enum NoteModel {
    enum PresentNote {
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

    enum SaveNote {
        struct Request {
            let date: String?
            let header: String?
            let body: String?
        }

        struct Response {
            let note: Note
        }

        struct ViewModel {}
    }
}
