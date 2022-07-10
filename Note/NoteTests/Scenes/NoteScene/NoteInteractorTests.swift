import XCTest
@testable import Note

final class NoteInteractorTests: XCTestCase {
    // MARK: - Props
    private var sut: NoteBusinessLogic!
    private var presenterMock: NotePresenterMock!
    private var workerMock: NoteWorker!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        presenterMock = NotePresenterMock()
        workerMock = NoteWorker()
        sut = NoteInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDown() {
        sut = nil
        presenterMock = nil
        workerMock = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func testPresenterWasCalled() {
        sut.requestNote(.init())

        XCTAssertTrue(
            presenterMock.presenterWasCalled,
            "Interactor should invoke Presenter"
        )
    }

    func testRequestNoteShouldAskPresenterToFormatResult() {
        let transmittedData = Note(
            header: "test",
            body: nil,
            date: nil,
            icon: nil
        )
        let expectedResponse = "test"

        sut.requestNote(.init())

        presenterMock.presentNote(
            .init(note: transmittedData)
        )

        XCTAssertEqual(
            presenterMock.responseMock?.note.header,
            expectedResponse,
            "requestNote() should ask presenter to format resuls"
        )
    }

    func testSaveNoteShouldAskPresenterToFormatNoteViewModel() {
        let transmittedData = NoteView.Model(
            header: "",
            body: "",
            date: ""
        )

        sut.saveNote(.init(note: transmittedData))

        XCTAssertTrue(
            presenterMock.presenterWasCalled,
            "saveNote() should ask presenter to format the NoteView Model"
        )
    }
}

// MARK: - Mocks
private final class NotePresenterMock: NotePresentationLogic {
    var presenterWasCalled = false
    var responseMock: NoteModel.SingleNote.Response?

    func presentNote(_ response: NoteModel.SingleNote.Response) {
        presenterWasCalled = true
        responseMock = response
    }
}
