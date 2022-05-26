import Foundation

class Worker: WorkerType {
    // MARK: - Props
    private var session: URLSession

    // MARK: - Initializers
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func fetch() {
        if let url = createURLComponents() {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([NoteData].self, from: data)
                addNotes(from: decodedData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func createURLComponents() -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "firebasestorage.googleapis.com"
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/Empty.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18")
        ]
        return urlComponents.url
    }

    private func addNotes(from data: [NoteData]) {
        data.forEach { note in
            SampleData.notes.append(
                Note(
                    header: note.header,
                    body: note.text,
                    date: Date(timeIntervalSince1970: TimeInterval(note.date ?? 0))
                )
            )
        }
    }
}
