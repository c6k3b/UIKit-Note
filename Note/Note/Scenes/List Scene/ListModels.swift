import UIKit

enum ListModel {
    enum PresentList {
        struct Request {}
        struct Response {
            let notes: [Note]
        }
        struct ViewModel { // swiftlint:disable nesting
            struct PresentedNote {
                let header: String
                let body: String
                let date: String
                let icon: UIImage
            }
            let presentedCells: [PresentedNote]
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
