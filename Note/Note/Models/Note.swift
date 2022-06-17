import UIKit

class Note {
    var header: String?
    var body: String?
    var date: Date
    var icon: UIImage?

    init(header: String? = nil, body: String? = nil, date: Date? = nil, icon: UIImage? = nil) {
        self.header = header
        self.body = body
        self.date = date ?? Date()
        self.icon = icon
    }
}
