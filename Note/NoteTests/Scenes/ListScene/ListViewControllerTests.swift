import XCTest
@testable import Note

final class ListViewControllerTests: XCTestCase {
    // MARK: - Props
    private var sut: ListViewController!
    private var interactor: ListInteractorMock!
    private var router: ListRouterMock!
    private var dataStore: ListDataStoreMock!

    // MARK: - Lifecycle
    override func setUp() {
        dataStore = ListDataStoreMock()
        interactor = ListInteractorMock()
        router = ListRouterMock(dataStore: dataStore)
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
