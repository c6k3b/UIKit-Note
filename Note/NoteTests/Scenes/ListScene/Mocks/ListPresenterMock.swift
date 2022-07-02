import Foundation
@testable import Note

//    final class ListPresenterMock: ListPresentationLogic {
//        var presenterWasCalled = false
//        var responseMock: ListModel.NotesList.Response?
//        var responseNotesRemovingMock: ListModel.NotesRemoving.Response?
//
//        var fetchResponse: (() -> Void)?
//        var fetchResponseNotesRemoving: (() -> Void)?
//
//        func presentNotes(_ response: ListModel.NotesList.Response) {
//            presenterWasCalled = true
//            responseMock = response
//            fetchResponse?()
//        }
//
//        func presentNotesRemoving(_ response: ListModel.NotesRemoving.Response) {
//            presenterWasCalled = true
//            responseNotesRemovingMock = response
//            fetchResponseNotesRemoving?()
//        }
//    }
