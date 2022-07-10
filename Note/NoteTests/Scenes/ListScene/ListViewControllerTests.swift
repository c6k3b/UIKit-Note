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
        dataStore = ListDataStoreMock()
        interactor = ListInteractorMock()
        router = ListRouter(dataStore: dataStore)
        sut = ListViewController(interactor: interactor, router: router)
        super.setUp()
    }

    override func tearDown() {
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func test_givenScene_whenPresenterCallsToShowFetchNotes_thenInteractorCalled() {
        sut.showNotesList()
        XCTAssertTrue(interactor.tryToFetchNotes)
    }

    func test_givenScene_whenPresenterCallsToPerformNotesRemoving_thenInteractorCalled() {
        sut.remove(indices: nil, cells: nil)
        XCTAssertTrue(interactor.tryToPerformNotesRemoving)
    }

    func test_givenScene_whenPresenterCallsStoreSelectedNoteNil_thenInteractorCalledFalse() {
        sut.storeSelectedNote(nil)
        XCTAssertFalse(interactor.tryToStoreSelectedNote)
    }

    func test_givenScene_whenPresenterCallsStoreSelectedNote_thenInteractorCalled() {
        sut.storeSelectedNote(0)
        XCTAssertTrue(interactor.tryToStoreSelectedNote)
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
    var notes: [Note] = [Note(header: "tested", body: nil, date: nil, icon: nil)]
    var note: Note = Note(header: "selected", body: nil, date: nil, icon: nil)
}
