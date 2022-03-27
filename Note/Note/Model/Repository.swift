import Foundation

class Repository {
    
    // MARK: - Props
    var note: Note?
    var files: FileSystemOperations?
    
    // MARK: - Methods
    func saveNote() {
        if let data = note?.body {
            files?.saveToDisk(Data(data.utf8))
        }
    }
    
    func getNote() -> String {
        if let data = files?.loadFromDisk() {
            return String(decoding: data, as: UTF8.self)
        }
        return ""
    }
}
