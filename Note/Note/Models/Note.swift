import Foundation

struct Note {
    var header: String?
    var body: String?
    var date: Date?
    var icon: Data?
}

struct NoteData: Decodable {
    let header: String?
    let text: String?
    let date: Int64?
    let userShareIcon: String?
}
