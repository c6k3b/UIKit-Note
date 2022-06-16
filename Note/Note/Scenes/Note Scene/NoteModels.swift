import Foundation
enum NoteModel {
    struct Request {}

    struct Response {
        let note: Note
    }

    struct ViewModel {
        let date: Date
        let header: String
        let body: String
    }
}
