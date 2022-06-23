import Foundation

protocol NetworkProtocol {
    func fetchData(completion: ([NoteData]) -> Void)
    func fetchImage(from stringUrl: String) -> Data?
}
