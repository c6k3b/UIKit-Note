import Foundation

class Worker: WorkerType {
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
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/Empty.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18")
        ]
        return urlComponents.url
    }
}
