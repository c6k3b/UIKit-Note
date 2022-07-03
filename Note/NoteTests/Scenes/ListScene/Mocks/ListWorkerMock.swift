import Foundation
@testable import Note

final class ListWorkerMock: ListWorkerLogic {
    var tryToGetNotes = false
    var result: [Note]? = [Note(header: "WorkerNote", body: "", date: Date(), icon: Data())]

    var fetchResponse: (() -> Void)?

    func getNotes(completion: ([Note]?) -> Void) {
        tryToGetNotes = true
        completion(result)
        fetchResponse?()
    }
}
