import Foundation

struct Worker: WorkerType {
    // MARK: - Props
    private var session = URLSession(configuration: .default)

    // MARK: - Methods
    func fetch(completion: ([NoteData]) -> Void) {
        var decodedData = [NoteData]()

        if let url = createURLComponents() {
            do {
                let data = try Data(contentsOf: url)
                decodedData = try JSONDecoder().decode([NoteData].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }

        completion(decodedData)
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
