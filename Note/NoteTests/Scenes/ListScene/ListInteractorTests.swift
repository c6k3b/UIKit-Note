import XCTest
@testable import Note

final class ListInteractorTests: XCTestCase {
    // MARK: - Props
    var sut: (ListBusinessLogic & ListDataStore)!
    var dataStoreMock: ListDataStoreMock!
    var presenterMock: ListPresenterMock!
    var workerMock: ListWorkerMock!

    // MARK: - Test Lifecycle
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
    func test_givenInteractor_whenTryToCallWorker_thenWorkerCalled() {
        let expectation = expectation(description: "wait for worker returns notes list")
        workerMock.fetchResponse = {
            XCTAssertTrue(self.workerMock.tryToGetNotes)
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func test_givenInteractor_whenTryToPresentNotes_thenPresenterCalled() {
        let expectation = expectation(description: "wait for presenter returns notes list")
        presenterMock.fetchResponse = {
            XCTAssert(self.presenterMock.tryToPresentNotes)
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Fetch Notes
    func test_givenInteractor_whenTryToGetNotes_andTryToPresentNotes_thenProperDataPassedToPresenter() {
        let expectation = expectation(description: "wait for send response to presenter")
        workerMock.result = [
            Note(header: "test", body: "", date: Date(), icon: Data()),
            Note()
        ]
        presenterMock.fetchResponse = {
            XCTAssertTrue(self.workerMock.tryToGetNotes)
            XCTAssertTrue(self.presenterMock.tryToPresentNotes)
            XCTAssertTrue(self.presenterMock.responseMock?.notes.count == 2)
            XCTAssertTrue(self.presenterMock.responseMock?.notes[0].header == "test")
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func test_givenInteractor_whenTryToGetNotes_andTryToPresentNotes_thenDataNotPassedToPresenter() {
        let expectation = expectation(description: "should not send response to presenter")

        presenterMock.fetchResponse = {
            XCTAssertTrue(self.workerMock.tryToGetNotes)
            XCTAssertTrue(self.presenterMock.tryToPresentNotes)
            XCTAssertTrue(self.presenterMock.responseMock?.notes.count == 1)
            XCTAssertTrue(self.presenterMock.responseMock?.notes[0].header == "WorkerNote")
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func test_givenInteractor_whenTryToAddNewNote_andTryPresentNotes_thenProperDataPassedToPresenter() {
        sut.notes = dataStoreMock.notes
        sut.note = dataStoreMock.note
        let notesCount = sut.notes.count + 1

        let expectation = expectation(description: "should add new note to list")
        sut.storeSelectedNote(nil)

        presenterMock.fetchResponse = {
            XCTAssertTrue(self.dataStoreMock.dataStoreWasCalled)
            XCTAssertTrue(self.sut.notes.count == notesCount)
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func test_givenInteractor_whenTryToUpdateExistingNote_andTryPresentNotes_thenProperDataPassedToPresenter() {
        let index = 0
        sut.notes = dataStoreMock.notes
        sut.note = dataStoreMock.note

        let expectation = expectation(description: "should update note")
        sut.storeSelectedNote(index)

        presenterMock.fetchResponse = {
            XCTAssertTrue(self.dataStoreMock.dataStoreWasCalled)
            XCTAssertTrue(self.sut.notes[0].header == "tested")
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Perform Notes Removing
    func test_givenInteractor_whenTryPresenterPerformNotesRemovingResponse_thenProperDataPassedToPresenter() {
        sut.notes = dataStoreMock.notes
        sut.performNotesRemoving(.init(indicesToRemove: [0]))

        XCTAssertTrue(self.dataStoreMock.dataStoreWasCalled)
        XCTAssertTrue(self.presenterMock.tryToPresentNotes)
        XCTAssertTrue(self.presenterMock.responseNotesRemovingMock?.indicesToRemove == [0])
    }

    func test_givenInteractor_whenTryPresenterPerformNotesRemovingResponse_thenNoDataPassedToPresenter() {
        sut.performNotesRemoving(.init(indicesToRemove: []))

        XCTAssertTrue(self.dataStoreMock.dataStoreWasCalled)
        XCTAssertTrue(self.presenterMock.tryToPresentNotes)
        XCTAssertTrue(self.presenterMock.responseNotesRemovingMock?.indicesToRemove.isEmpty != nil)
    }
}
