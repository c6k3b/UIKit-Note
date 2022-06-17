enum NoteModel {
    struct Request {}

    struct Response {
        let note: Note
    }

    struct ViewModel {
        let date: String
        let header: String
        let body: String
//        let note: Note
    }
}
