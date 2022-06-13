import Foundation
import UIKit

enum AddNoteModel {
    enum InitForm {
        struct Request {}

        struct Response {}

        struct ViewModel {
            let header: String?
            let body: String?
            let date: String
//            let icon: UIImage?
        }
    }
}
