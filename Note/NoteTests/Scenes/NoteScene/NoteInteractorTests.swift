import XCTest
@testable import Note

final class NoteInteractorTests: XCTestCase {
    // MARK: - Props
    private var sut: NoteBusinessLogic!
    private var presenterMock: NotePresenterMock!
    private var workerMock: NoteWorkerMock!

    private var note: NoteView.Model? = NoteView.Model(header: "", body: "", date: "")

    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        presenterMock = NotePresenterMock()
        workerMock = NoteWorkerMock()
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
        XCTAssert(presenterMock.presenterWasCalled, "interactor should call presenter method")
    }

    // Present
    func testPresenterRequestNoteResponse() {
        sut.requestNote(.init())

        presenterMock.presentNote(
            .init(note: Note(header: "test", body: "", date: Date(), icon: Data()))
        )

        XCTAssertTrue(presenterMock.presenterWasCalled, "should send response to presenter")
        XCTAssertTrue(presenterMock.responseMock?.note.header == "test")
    }

    func testPresenterRequestNoteResponseFalse() {
        sut.requestNote(.init())

        presenterMock.presentNote(.init(note: Note()))
        XCTAssertTrue(presenterMock.presenterWasCalled, "should not send response to presenter")
        XCTAssertTrue(presenterMock.responseMock?.note.header == nil)
    }

    // Save
    func testPresenterSaveNoteResponse() {
        sut.saveNote(.init(note: note!))

        XCTAssertTrue(presenterMock.presenterWasCalled, "should send response to presenter")
        XCTAssertTrue(presenterMock.responseMockSaving == nil)
    }
}
