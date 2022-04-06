import Foundation

struct Note {
    var header: String?
    var body: String?
    var date: Date = Date()
    var isEmpty: Bool {
        return (header == nil && body == nil) || (header!.isEmpty && body!.isEmpty) ? true : false
    }
}
