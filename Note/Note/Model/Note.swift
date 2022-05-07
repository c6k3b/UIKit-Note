import Foundation

class Note {
    var header: String?
    var body: String?
    var date: String?

    var isEmpty: Bool {
        header?.isEmpty ?? true && body?.isEmpty ?? true
    }

    init(header: String? = nil, body: String? = nil, date: Date? = nil) {
        self.header = header
        self.body = body
        self.date = date ?? Date()
    }
}
