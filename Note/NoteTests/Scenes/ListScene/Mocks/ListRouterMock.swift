import Foundation
@testable import Note

final class ListRouterMock: (ListRoutingLogic & ListDataPassing) {
    var dataStore: ListDataStore

    init(dataStore: ListDataStoreMock) {
        self.dataStore = dataStore
    }

    var tryToRoute = false
    func route() {
        tryToRoute = true
    }
}
