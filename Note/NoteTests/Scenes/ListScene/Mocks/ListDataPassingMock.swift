import Foundation
@testable import Note

final class ListDataPassingMock: ListDataPassing {
    var dataStore: ListDataStore

    init(dataStore: ListDataStoreMock) {
        self.dataStore = dataStore
    }
}
