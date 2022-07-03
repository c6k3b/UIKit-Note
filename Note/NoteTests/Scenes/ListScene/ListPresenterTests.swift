import XCTest
@testable import Note

final class ListPresenterTests: XCTestCase {
    // MARK: - Props
    private var sut: ListPresenter!
    private var viewControllerMock: ListViewControllerMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        viewControllerMock = ListViewControllerMock()
        sut = ListPresenter()
        sut.viewController = viewControllerMock
    }

    override func tearDown() {
        sut = nil
        viewControllerMock = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func test_givenPresenter_whenPresentNotesCalled_thenVCsProperMethodInvoked() {
        sut.presentNotes(.init(notes: [Note()]))
        XCTAssertTrue(viewControllerMock.displayNotesCalled.0)
    }

    func test_givenPresenter_whenPresentNotesRemovingCalled_thenVCsProperMethodInvoked() {
        sut.presentNotesRemoving(.init(indicesToRemove: [0]))
        XCTAssertTrue(viewControllerMock.displayNotesRemovingCalled.0)
    }

    func test_givenPresenter_whenPresentNotesRemovingCalledSuccess_thenVCsProperArgumentPassed() {
        let expectedResult = ListModel.NotesRemoving.ViewModel.success(indicesToRemove: [0])

        sut.presentNotesRemoving(.init(indicesToRemove: [0]))
        XCTAssertNotNil(viewControllerMock.displayNotesRemovingCalled.1)
        XCTAssertEqual(viewControllerMock.displayNotesRemovingCalled.1, expectedResult)
    }

    func test_givenPresenter_whenPresentNotesRemovingCalledFailure_thenVCsProperArgumentPassed() {
        let expectedResponse = ListModel.NotesRemoving.ViewModel.failure(
            alert: ListModel.NotesRemoving.ViewModel.Alert(
                title: Styles.AlertNoSelection.title,
                message: Styles.AlertNoSelection.message,
                actionTitle: Styles.AlertNoSelection.actionTitle
            )
        )

        sut.presentNotesRemoving(.init(indicesToRemove: []))
        XCTAssertNotNil(viewControllerMock.displayNotesRemovingCalled.1)
        XCTAssertEqual(viewControllerMock.displayNotesRemovingCalled.1, expectedResponse)
    }
}
