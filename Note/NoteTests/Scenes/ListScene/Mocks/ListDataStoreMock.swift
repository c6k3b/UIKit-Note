import Foundation
@testable import Note

final class ListDataStoreMock: ListDataStore {
    var dataStoreWasCalled = true
    var notes: [Note] = [Note(header: "tested", body: nil, date: nil, icon: nil)]
    var note: Note = Note(header: "selected", body: nil, date: nil, icon: nil)
}
