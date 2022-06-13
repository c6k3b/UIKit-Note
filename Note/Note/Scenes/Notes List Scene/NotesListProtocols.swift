import Foundation
import UIKit

protocol NotesListDataStore: AnyObject {
//    func passData(from note: Note, isChanged: Bool)
    var notes: [Note] { get }
}

protocol NotesListBusinessLogic {
    func requestInitForm(_ request: NotesListModels.InitForm.Request)
}

protocol NotesListWorkerLogic {
    func fetch(completion: ([NoteData]) -> Void)
    func getImageData(from stringUrl: String) -> Data?
}

protocol NotesListPresentationLogic {
    func presentInitForm(_ response: NotesListModels.InitForm.Response)
}

protocol NotesListDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: NotesListModels.InitForm.ViewModel)
}

protocol NotesListRoutingLogic {
//    var dataStore: NotesListDataStore { get }
//
//    init(data: (sourse: NotesListDataStore, destination: AddNoteDataStore))
}
