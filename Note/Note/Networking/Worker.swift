import Foundation

class Worker: WorkerType {
    // MARK: - Props
    private var session = URLSession(configuration: .default)

    // MARK: - Methods
    func fetch(completion: (Data) -> Void) {
        var data = Data()

        if let url = createURLComponents() {
            do {
                data = try Data(contentsOf: url)
            } catch {
                print(error.localizedDescription)
            }
        }

        completion(data)
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
