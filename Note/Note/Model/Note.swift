import Foundation

class Note {
    var header: String?
    var body: String?
    var date: Date
    var isEditingMode: Bool

    var isEmpty: Bool {
        header?.isEmpty ?? true && body?.isEmpty ?? true
    }

    init(header: String? = nil, body: String? = nil, date: Date? = nil, isEditingMode: Bool = false) {
        self.header = header
        self.body = body
        self.date = date ?? Date()
        self.isEditingMode = isEditingMode
    }
}
