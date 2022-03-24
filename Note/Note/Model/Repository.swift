import Foundation

class Repository {
    
    // MARK: - Props
    var note: Note?
    var files: FileSystemOperations?
    private static var shared: Repository?
    
    // MARK: - Initializers
    private init() {}
    
    static func sharedInstance() -> Repository {
        if shared == nil {
            shared = Repository()
        }
        return shared!
    }
    
    // MARK: - Methods
    func getNote() {
        
    }
    
    func saveNote() {
        
    }
}
