import Foundation

struct NetworkManager {
    // MARK: - Props
    private let session = URLSession(configuration: .default)

    // MARK: - Methods
    func fetchData(completion: ([NoteData]) -> Void) {
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

    func fetchImage(from stringUrl: String) -> Data? {
        guard let url = URL(string: stringUrl) else { return nil }
        var imageData = Data()
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        return imageData
    }

    // MARK: - Private
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