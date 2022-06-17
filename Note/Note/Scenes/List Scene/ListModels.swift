import UIKit

enum ListModel {
    struct Request {}

    struct Response {
        let notes: [Note]
    }

    struct ViewModel {
        struct PresentedNoteCell {
            let header: String
            let body: String
            let date: String
            let icon: UIImage
        }
        let presentedCells: [PresentedNoteCell]
    }
}
