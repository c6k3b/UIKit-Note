import Foundation
@testable import Note

final class ListDataStoreMock: ListDataStore {
    var dataStoreWasCalled = true
    var notes: [Note] = [Note(), Note()]
    var note: Note = Note()
}
