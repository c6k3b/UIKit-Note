import UIKit

enum NotesListModel {
    enum ShowNotesList {
        struct Request {}
        struct Response { var notes: [Note] }
        struct ViewModel { let notes: [Note] }
    }
}
