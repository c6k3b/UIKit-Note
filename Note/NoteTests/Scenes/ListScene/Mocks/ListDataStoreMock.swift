import Foundation
@testable import Note

final class ListDataStoreMock: ListDataStore {
    var dataStoreWasCalled = false
    var notes: [Note] = [Note()]
    var note: Note = Note()
}
