import Foundation
import UIKit

class Note {
    var header: String?
    var body: String?
    var date: Date
    var icon: UIImage?

    var isEmpty: Bool {
        header?.isEmpty ?? true && body?.isEmpty ?? true
    }

    init(header: String? = nil, body: String? = nil, date: Date? = nil, icon: UIImage? = nil) {
        self.header = header
        self.body = body
        self.date = date ?? Date()
        self.icon = icon
    }
}
