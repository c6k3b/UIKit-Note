import Foundation

struct NoteData: Decodable {
    let header: String?
    let text: String?
    let date: Int64?
}
