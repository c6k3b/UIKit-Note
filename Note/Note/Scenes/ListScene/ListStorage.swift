import Foundation

final class ListStorage: ListDataStore {
    private var notes: [Note]
    private var note: Note

    init(notes: [Note], note: Note) {
        self.notes = notes
        self.note = note
    }

    func load() -> ListModel.Storage.Response {
        ListModel.Storage.Response()
    }

    func save(_ model: ListModel.Storage.Response) {
    }
}
