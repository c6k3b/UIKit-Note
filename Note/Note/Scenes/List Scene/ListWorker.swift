import Foundation

final class ListWorker: ListWorkerLogic {
    func getNotes(completion: ([Note]) -> Void) {
        var store: [Note] = []
        fetchData { noteData in
            store = noteData.map {
                Note(
                    header: $0.header,
                    body: $0.text,
                    date: Date(timeIntervalSince1970: TimeInterval($0.date ?? 0)),
                    icon: fetchImage(from: $0.userShareIcon ?? "")
                )
            }
        }
        completion(store)
    }
}

private extension ListWorker {
    private func fetchData(completion: ([NoteData]) -> Void) {
        guard let url = createURLComponents() else { return }
        var decodedData = [NoteData]()
        do {
            let data = try Data(contentsOf: url)
            decodedData = try JSONDecoder().decode([NoteData].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        completion(decodedData)
    }

    private func fetchImage(from stringUrl: String) -> Data? {
        guard let url = URL(string: stringUrl) else { return nil }
        var imageData = Data()
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        return imageData
    }

    private func createURLComponents() -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "firebasestorage.googleapis.com"
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/lesson8.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "215055df-172d-4b98-95a0-b353caca1424")
        ]
        return urlComponents.url
    }
}
