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
        urlComponents.path = "/v0/b/ios-test-ce687.appspot.com/o/lesson8.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "215055df-172d-4b98-95a0-b353caca1424")
        ]
        return urlComponents.url
    }
}
