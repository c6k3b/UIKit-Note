import Foundation
@testable import Note

final class ListDataStoreMock: ListDataStore {
    var dataStoreWasCalled = true
    var notes: [Note] = [Note(header: "tested", body: "", date: Date(), icon: Data())]
    var note: Note = Note(header: "selected", body: "", date: Date(), icon: Data())
}
