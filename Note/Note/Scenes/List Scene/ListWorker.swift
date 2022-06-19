import Foundation

final class ListWorker: ListWorkerLogic {
    private let networkManager = NetworkManager()

    func getNotes(completion: ([Note]) -> Void) {
        var store: [Note] = []
        networkManager.fetchData { noteData in
            store = noteData.map {
                Note(
                    header: $0.header,
                    body: $0.text,
                    date: Date(timeIntervalSince1970: TimeInterval($0.date ?? 0)),
                    icon: self.networkManager.fetchImage(
                            from: $0.userShareIcon ?? ""
                        )
                )
            }
        }
        completion(store)
    }
}
