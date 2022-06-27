import Foundation
@testable import Note

final class ListWorkerMock: ListWorkerLogic {
    var getNotesWasCalled = false
    var result: [Note]?

    var fetchResponse: (() -> Void)?

    func getNotes(completion: ([Note]?) -> Void) {
        getNotesWasCalled = true
        completion(result)
        fetchResponse?()
    }
}
