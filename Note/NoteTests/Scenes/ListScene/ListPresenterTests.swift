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
    func testPresenterShouldAckViewControllerToPresentNotes() {
        let transmittedData = [Note()]

        sut.presentNotes(.init(notes: transmittedData))

        XCTAssertTrue(
            viewControllerMock.displayNotesCalled.isCalled,
            "Presenter should invoke ViewController to display notes"
        )
    }

    func testPresenterShouldCallViewControllerToDisplayNotesRemoving() {
        let transmittedData = [0]

        sut.presentNotesRemoving(.init(indicesToRemove: transmittedData))

        XCTAssertTrue(
            viewControllerMock.displayNotesRemovingCalled.isCalled,
            "Presenter should invoke ViewController to display notes removing"
        )
    }

    func testPresenterShouldAskViewControllerToDisplayNotesRemoving() {
        let transmittedData = [0]
        let expectedResult = ListModel.NotesRemoving.ViewModel.success(indicesToRemove: transmittedData)

        sut.presentNotesRemoving(.init(indicesToRemove: transmittedData))

        XCTAssertEqual(
            viewControllerMock.displayNotesRemovingCalled.data,
            expectedResult,
            "Presenter should send proper note index to ViewController to display notes removing"
        )
    }

    func testPresenterShouldAskViewControllerToDisplayNoSelectionForDeleteNotesAlert() {
        let transmittedData = [Int]()
        let expectedResponse = ListModel.NotesRemoving.ViewModel.failure(
            alert: ListModel.NotesRemoving.ViewModel.Alert(
                title: Styles.AlertNoSelectionForDeleteNotes.title,
                message: Styles.AlertNoSelectionForDeleteNotes.message,
                actionTitle: Styles.AlertNoSelectionForDeleteNotes.actionTitle
            )
        )

        sut.presentNotesRemoving(.init(indicesToRemove: transmittedData))

        XCTAssertNotNil(
            viewControllerMock.displayNotesRemovingCalled.data,
            "Presenter should send empty index array to ViewController"
        )

        XCTAssertEqual(
            viewControllerMock.displayNotesRemovingCalled.data,
            expectedResponse,
            "Presenter should send proper data to ViewController to display no selected data error alert"
        )
    }
}

// MARK: - Mocks
private final class ListViewControllerMock: ListDisplayLogic {
    var displayNotesCalled: (isCalled: Bool, data: ListModel.NotesList.ViewModel)!
    var displayNotesRemovingCalled: (isCalled: Bool, data: ListModel.NotesRemoving.ViewModel)!

    func displayNotes(_ viewModel: ListModel.NotesList.ViewModel) {
        displayNotesCalled = (isCalled: true, data: viewModel)
    }

    func displayNotesRemoving(_ viewModel: ListModel.NotesRemoving.ViewModel) {
        displayNotesRemovingCalled = (isCalled: true, data: viewModel)
    }
}
