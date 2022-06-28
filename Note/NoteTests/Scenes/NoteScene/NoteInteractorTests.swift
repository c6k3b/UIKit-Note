import XCTest
@testable import Note

final class NoteInteractorTests: XCTestCase {
    // MARK: - Props
    var sut: NoteBusinessLogic!
    var presenterMock: NotePresenterMock!
    var workerMock: NoteWorkerMock!

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

    func testPresenterResponse() {
        sut.requestNote(.init())

        presenterMock.presentNote(
            .init(note: Note(header: "test", body: "", date: Date(), icon: Data()))
        )

        XCTAssertTrue(presenterMock.presenterWasCalled, "should send response to presenter")
        XCTAssertTrue(presenterMock.responseMock?.note.header == "test")
    }

    func testPresenterResponseFalse() {
        sut.requestNote(.init())

        presenterMock.presentNote(.init(note: Note()))
        XCTAssertTrue(presenterMock.presenterWasCalled, "should not send response to presenter")
        XCTAssertTrue(presenterMock.responseMock?.note.header == nil)
    }
}
