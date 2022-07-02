import XCTest
@testable import Note

final class ListPresenterTests: XCTestCase {
    // MARK: - Props
    private var sut: ListPresentationLogic!
    private var viewController: ListViewControllerSpy!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        viewController = ListViewControllerSpy()
        sut = ListPresenter()
        sut.viewController = viewController
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func test_givenPresenter_whenPresentNotesCalled_thenVCsProperMethodInvoked() {
        sut.presentNotes(.init(notes: [Note()]))
        XCTAssertTrue(viewController.displayNotesCalled.0)
    }

    func test_givenPresenter_whenPresentNotesRemovingCalled_thenVCsProperMethodInvoked() {
        sut.presentNotesRemoving(.init(indicesToRemove: [0]))
        XCTAssertTrue(viewController.displayNotesRemovingCalled.0)
    }

    func test_givenPresenter_whenPresentNotesCalled_thenVCsArgumentPassed() {
        sut.presentNotes(.init(notes: [Note()]))
        XCTAssertNotNil(viewController.displayNotesCalled.1)
    }

    func test_givenPresenter_whenPresentNotesRemovingCalled_thenVCsArgumentPassed() {
        sut.presentNotesRemoving(.init(indicesToRemove: [0]))
        XCTAssertNotNil(viewController.displayNotesRemovingCalled.1)
    }
}

// MARK: - Mocks
private final class ListViewControllerSpy: ListDisplayLogic {
    var displayNotesCalled: (Bool, ListModel.NotesList.ViewModel)!
    var displayNotesRemovingCalled: (Bool, ListModel.NotesRemoving.ViewModel)!

    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel) {
        displayNotesCalled = (true, viewModel)
    }

    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel) {
        displayNotesRemovingCalled = (true, viewModel)
    }
}
