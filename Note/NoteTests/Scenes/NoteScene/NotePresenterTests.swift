import XCTest
@testable import Note

final class NotePresenterTests: XCTestCase {
    // MARK: - Props
    private var sut: NotePresenter!
    private var viewControllerMock: NoteViewControllerMock!

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
    func testPresenterShouldCallViewControllerToDisplayNote() {
        let transmittedData = Note()

        sut.presentNote(.init(note: transmittedData))

        XCTAssertTrue(
            viewControllerMock.displayNoteCalled.isCalled,
            "Presenter should invoke ViewController to display note"
        )
    }

    func testPresenterShouldAskViewControlletToDisplayNewNote() {
        let transmittedData = Note(header: "test", body: nil, date: nil, icon: nil)
        let expectedResult = NoteModel.SingleNote.ViewModel.success(
            note: NoteView.Model(
                header: "test",
                body: "",
                date: Date().getFormattedDate(
                    format: Styles.DateFormat.inView
                )
            )
        )

        sut.presentNote(.init(note: transmittedData))

        XCTAssertEqual(
            viewControllerMock.displayNoteCalled.data,
            expectedResult,
            "Presenter should send proper data to ViewController to display empty note alert"
        )
    }

    func testPresenterShouldAskViewControllerToDisplayEmptyNoteAlert() {
        let transmittedData = Note(header: "", body: "", date: nil, icon: nil)
        let expectedResponse = NoteModel.SingleNote.ViewModel.failure(
            alert: NoteModel.SingleNote.ViewModel.Alert(
                title: Styles.AlertEmptyNoteHeaderOrBody.title,
                message: Styles.AlertEmptyNoteHeaderOrBody.message,
                actionTitle: Styles.AlertEmptyNoteHeaderOrBody.actionTitle
            )
        )

        sut.presentNote(.init(note: transmittedData))

        XCTAssertNotNil(
            viewControllerMock.displayNoteCalled.data,
            "Presenter should send empty header and body to ViewConroller"
        )
        XCTAssertEqual(
            viewControllerMock.displayNoteCalled.data,
            expectedResponse,
            "Presenter should send proper data to ViewController to present empty note alert"
        )
    }
}

// MARK: - Mocks
private final class NoteViewControllerMock: NoteDisplayLogic {
    var displayNoteCalled: (isCalled: Bool, data: NoteModel.SingleNote.ViewModel)!

    func displayNote(_ viewModel: NoteModel.SingleNote.ViewModel) {
        displayNoteCalled = (isCalled: true, data: viewModel)
    }
}
