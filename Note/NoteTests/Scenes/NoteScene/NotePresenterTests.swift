import XCTest
@testable import Note

final class NotePresenterTests: XCTestCase {
    // MARK: - Props
    var sut: NotePresenter!
    var viewControllerMock: NoteViewControllerMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        viewControllerMock = NoteViewControllerMock()
        sut = NotePresenter()
        sut.viewController = viewControllerMock
    }

    override func tearDown() {
        sut = nil
        viewControllerMock = nil
        super.tearDown()
    }
    // MARK: - Test Methods
    func test_givenPresenter_whenPresentNoteCalled_thenVCsProperMethodInvoked() {
        sut.presentNote(.init(note: Note()))
        XCTAssertTrue(viewControllerMock.displayNoteCalled.0)
    }

    func test_givenPresenter_whenPresentNoteCalledSuccess_thenVCsProperArgumentPassed() {
        let expectedResult = NoteModel.SingleNote.ViewModel.success(
            note: NoteView.Model(
                header: "test",
                body: "",
                date: Date().getFormattedDate(
                    format: Styles.DateFormat.inView
                )
            )
        )

        sut.presentNote(.init(note: Note(header: "test", body: nil, date: nil, icon: nil)))
        XCTAssertNotNil(viewControllerMock.displayNoteCalled.1)
        XCTAssertEqual(viewControllerMock.displayNoteCalled.1, expectedResult)
    }

    func test_givenPresenter_whenPresentNoteCalledFailure_thenVCsProperArgumentPassed() {
        let expectedResponse = NoteModel.SingleNote.ViewModel.failure(
            alert: NoteModel.SingleNote.ViewModel.Alert(
                title: Styles.AlertEmpty.title,
                message: Styles.AlertEmpty.message,
                actionTitle: Styles.AlertEmpty.actionTitle
            )
        )

        sut.presentNote(.init(note: Note(header: "", body: "", date: nil, icon: nil)))
        XCTAssertNotNil(viewControllerMock.displayNoteCalled.1)
        XCTAssertEqual(viewControllerMock.displayNoteCalled.1, expectedResponse)
    }
}
