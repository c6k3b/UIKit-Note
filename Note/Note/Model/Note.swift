import Foundation

struct Note {
    var header: String?
    var body: String?
    var date = Date()

    var isEmpty: Bool {
        header?.isEmpty ?? true && body?.isEmpty ?? true
    }
}
