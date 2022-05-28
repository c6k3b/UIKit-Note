import Foundation

class Note {
    var header: String?
    var body: String?
    var date: Date
    var icon: String?

    var isEmpty: Bool {
        header?.isEmpty ?? true && body?.isEmpty ?? true
    }

    init(header: String? = nil, body: String? = nil, date: Date? = nil, icon: String? = nil) {
        self.header = header
        self.body = body
        self.date = date ?? Date()
        self.icon = icon
    }
}
