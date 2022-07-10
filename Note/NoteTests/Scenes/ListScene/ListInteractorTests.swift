import XCTest
@testable import Note

final class ListInteractorTests: XCTestCase {
    // MARK: - Props
    private var sut: (ListBusinessLogic & ListDataStore)!
    private var dataStoreMock: ListDataStoreMock!
    private var presenterMock: ListPresenterMock!
    private var workerMock: ListWorkerMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        dataStoreMock = ListDataStoreMock()
        presenterMock = ListPresenterMock()
        workerMock = ListWorkerMock()
        sut = ListInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDown() {
        sut = nil
        dataStoreMock = nil
        presenterMock = nil
        workerMock = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func testFetchResponseShouldCallWorker() {
        let expectation = expectation(description: "Wait for Worker returns notes list")
        workerMock.fetchResponse = {
            XCTAssertTrue(
                self.workerMock.tryToGetNotes,
                "Interactor should try to get notes and invoke Worker"
            )
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func testFetchResponseShouldCallPresenter() {
        let expectation = expectation(description: "Wait for presenter present notes list")

        presenterMock.fetchResponse = {
            XCTAssert(
                self.presenterMock.tryToPresentNotes,
                "Interactor should try to present notes list and invoke Presenter"
            )
            expectation.fulfill()
        }

        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Fetch Notes
    func testFetchNotesIfWorkerEmptyResponseShouldAskPresenterFormatSameResult() {
        let expectation = expectation(description: "Wait for send response to presenter")

        presenterMock.fetchResponse = {
            XCTAssertEqual(
                self.presenterMock.responseMock?.notes[0].header,
                self.workerMock.result?[0].header,
                "Should ask Presenter format same header of the first note"
            )
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func testFetchNotesShouldAskPresenterToFormatResult() {
        let expectedResponse = [
            Note(
                header: "test",
                body: nil,
                date: nil,
                icon: nil
                ),
            Note()
        ]
        workerMock.result = expectedResponse

        let expectation = expectation(description: "Wait for send response to presenter")

        presenterMock.fetchResponse = {
            XCTAssertEqual(
                self.presenterMock.responseMock?.notes[0].header,
                expectedResponse[0].header,
                "Should ask Presenter format new header of the first note"
            )
            expectation.fulfill()
        }

        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Notes List Update
    func testNotesListUpdateShouldAskPresenterToFormatNewNotesList() {
        sut.notes = dataStoreMock.notes
        sut.note = dataStoreMock.note
        let expectedResponse = sut.notes.count + 1

        let expectation = expectation(description: "Wait for send response to Presenter")

        sut.storeSelectedNote(nil)

        presenterMock.fetchResponse = {
            XCTAssertEqual(
                self.sut.notes.count,
                expectedResponse,
                "Presenter should format new notes list"
            )
            expectation.fulfill()
        }

        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func testNoteListUpdateShouldAskPresenterToReplaceNote() {
        sut.notes = dataStoreMock.notes
        sut.note = dataStoreMock.note

        let transmittedData = 0
        let expextedResponse = sut.notes[0].header

        let expectation = expectation(description: "Wait for send response to Presenter")

        sut.storeSelectedNote(transmittedData)

        presenterMock.fetchResponse = {
            XCTAssertEqual(
                self.sut.notes[0].header,
                expextedResponse,
                "Presenter should format the new header of the first note"
            )
            expectation.fulfill()
        }

        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Store notes
    func testStoreSelectedNoteShouldAskPresenterFormatResultWithoutChanges() {
        sut.notes = dataStoreMock.notes
        sut.note = dataStoreMock.note

        let transmittedData: Int? = nil
        let expectedResponse = dataStoreMock.notes[0].header

        sut.storeSelectedNote(transmittedData)

        XCTAssertEqual(
            self.sut.notes[0].header,
            expectedResponse,
            "Presenter should format result without changes"
        )
    }

    func testStoreSelectedNoteShouldAskPresenterFormatNewNote() {
        sut.notes = dataStoreMock.notes
        sut.note = dataStoreMock.note

        let transmittedData = 0
        let expectedResponse = sut.notes[0].header

        sut.storeSelectedNote(transmittedData)

        XCTAssertEqual(
            self.sut.note.header,
            expectedResponse,
            "Presenter should format the new header of the first note"
        )
    }

    // Perform Notes Removing
    func testPerformNotesRemovingShouldAskPresenterToFormatArrayOfIndicesToBeRemoved() {
        sut.notes = dataStoreMock.notes

        let transmittedData = [0]

        sut.performNotesRemoving(.init(indicesToRemove: transmittedData))

        XCTAssertEqual(
            self.presenterMock.responseNotesRemovingMock?.indicesToRemove,
            transmittedData,
            "Presenter should format array of indices to be removed"
        )
    }
}

// MARK: - Mocks
private final class ListPresenterMock: ListPresentationLogic {
    var tryToPresentNotes = false
    var responseMock: ListModel.NotesList.Response?
    var responseNotesRemovingMock: ListModel.NotesRemoving.Response?

    var fetchResponse: (() -> Void)?
    var fetchResponseNotesRemoving: (() -> Void)?

    func presentNotes(_ response: ListModel.NotesList.Response) {
        tryToPresentNotes = true
        responseMock = response
        fetchResponse?()
    }

    func presentNotesRemoving(_ response: ListModel.NotesRemoving.Response) {
        tryToPresentNotes = true
        responseNotesRemovingMock = response
        fetchResponseNotesRemoving?()
    }
}

private final class ListWorkerMock: ListWorkerLogic {
    var tryToGetNotes = false
    var result: [Note]? = [Note(header: "WorkerNote", body: nil, date: nil, icon: nil)]

    var fetchResponse: (() -> Void)?

    func getNotes(completion: ([Note]?) -> Void) {
        tryToGetNotes = true
        completion(result)
        fetchResponse?()
    }
}

private final class ListDataStoreMock: ListDataStore {
    var notes = [Note(header: "new note", body: nil, date: nil, icon: nil)]
    var note = Note(header: "old note", body: nil, date: nil, icon: nil)
}
