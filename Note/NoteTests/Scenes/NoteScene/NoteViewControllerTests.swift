import XCTest
@testable import Note

final class NoteViewControllerTests: XCTestCase {
    // MARK: - Props
    private var sut: NoteViewController!
    private var interactor: NoteInteractorMock!
    private var router: NoteRouter!
    private var dataStore: NoteDataStoreMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        dataStore = NoteDataStoreMock()
        interactor = NoteInteractorMock()
        router = NoteRouter(dataStore: dataStore)
        sut = NoteViewController(interactor: interactor, router: router)
    }

    override func tearDown() {
        dataStore = nil
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func testRequestNoteShouldCallInteractor() {
        interactor.requestNote(NoteModel.SingleNote.Request())

        XCTAssertTrue(
            interactor.tryToRequestNote,
            "requestNote() should invoke Interactor"
        )
    }

    func testSaveNoteShouldCallInteractor() {
        let transmittedData = sut.note

        interactor.saveNote(
            NoteModel.NoteSaving.Request(note: transmittedData)
        )

        XCTAssertTrue(
            interactor.tryToSaveNote,
            "saveNote() should invoke Interactor"
        )
    }

    func testInitWithCoder() {
        let viewController = NoteViewController(coder: NSCoder())
        let view = NoteView(coder: NSCoder())
        XCTAssertNil(viewController)
        XCTAssertNil(view)
    }

    func testDisplayNote() {
        let transmittedData = NoteView.Model(
            header: "Test",
            body: "",
            date: ""
        )
        let expectedResult = transmittedData.header

        sut.displayNote(.success(note: transmittedData))

        XCTAssertEqual(
            sut.note.header,
            expectedResult,
            "displayNote() should present NoteView.Model"
        )
    }

    func testDisplayAlert() {
        let transmittedData = NoteModel.SingleNote.ViewModel.Alert(
            title: Styles.AlertEmptyNoteHeaderOrBody.title,
            message: Styles.AlertEmptyNoteHeaderOrBody.message,
            actionTitle: Styles.AlertEmptyNoteHeaderOrBody.actionTitle
        )
        let expectedResult = sut.note.header

        sut.displayNote(.failure(alert: transmittedData))

        XCTAssertEqual(
            sut.note.header,
            expectedResult,
            "displayNote() should present Alert"
        )
    }
}

// MARK: - Mocks
private final class NoteInteractorMock: NoteBusinessLogic {
    var tryToRequestNote = false
    var tryToSaveNote = false

    func requestNote(_ request: NoteModel.SingleNote.Request) {
        tryToRequestNote = true
    }

    func saveNote(_ request: NoteModel.NoteSaving.Request) {
        tryToSaveNote = true
    }
}

private final class NoteDataStoreMock: NoteDataStore {
    var note: Note = Note(header: "Note", body: nil, date: nil, icon: nil)
}
