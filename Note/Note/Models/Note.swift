import Foundation

class Note {
    var header: String?
    var body: String?
    var date: Date?
    var icon: Data?

    init(header: String? = nil, body: String? = nil, date: Date? = nil, icon: Data? = nil) {
        self.header = header
        self.body = body
        self.date = date ?? Date()
        self.icon = icon
    }
}
