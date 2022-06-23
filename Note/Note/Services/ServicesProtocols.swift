import Foundation

protocol NotesStoreProtocol {
    func remove(_ index: [Int]?, completion: (([Note]?) -> Void))
    func update(completion: (([Note]?) -> Void))
}
