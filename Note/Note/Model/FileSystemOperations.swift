import Foundation

struct FileSystemOperations {
    
    // MARK: - Props
    private let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private lazy var fileURL = URL(fileURLWithPath: "note", relativeTo: directoryURL)
    
    // MARK: - Methods
    mutating func saveToDisk(_ data: Data) {
        do {
            try data.write(to: fileURL)
            print("file saved: \(fileURL.absoluteURL)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    mutating func loadFromDisk() -> Data? {
        do {
            let savedData = try Data(contentsOf: fileURL)
            return savedData
        } catch {
            print("cant read the file")
        }
        return nil
    }
}
