import XCTest
@testable import Note

final class ListViewControllerTests: XCTestCase {
    // MARK: - Props
    private var sut: ListViewController!
    private var interactor: ListInteractorMock!
    private var router: ListRouter!
    private var dataStore: ListDataStoreMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        dataStore = ListDataStoreMock()
        interactor = ListInteractorMock()
        router = ListRouter(dataStore: dataStore)
        sut = ListViewController(interactor: interactor, router: router)
    }

    override func tearDown() {
        dataStore = nil
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func testShowNotesListShouldAskPresenterToPresentNotes() {
        sut.showNotesList()
        XCTAssertTrue(interactor.tryToFetchNotes)
    }

    func testRemoveShouldAskPresenterToPresentNotesRemoving() {
        sut.remove(indices: nil, cells: nil)
        XCTAssertTrue(interactor.tryToPerformNotesRemoving)
    }
}

// MARK: - Mocks
private final class ListInteractorMock: ListBusinessLogic {
    var tryToFetchNotes = false
    var tryToPerformNotesRemoving = false
    var tryToStoreSelectedNote = false

    func fetchNotes(_ request: ListModel.NotesList.Request) {
        tryToFetchNotes = true
    }

    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request) {
        tryToPerformNotesRemoving = true
    }

    func storeSelectedNote(_ index: Int?) {
        tryToStoreSelectedNote = true
    }
}

private final class ListDataStoreMock: ListDataStore {
    var dataStoreWasCalled = true
    var notes: [Note] = [Note(header: "ListNote", body: nil, date: nil, icon: nil)]
    var note: Note = Note(header: "Note", body: nil, date: nil, icon: nil)
}
