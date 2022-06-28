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
    func testWorkerWasCalled() {
        let expectation = expectation(description: "interactor should call the worker method")
        workerMock.fetchResponse = {
            XCTAssertTrue(self.workerMock.getNotesWasCalled)
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func testPresenterWasCalled() {
        let expectation = expectation(description: "interactor should call presenter method")
        presenterMock.fetchResponse = {
            XCTAssert(self.presenterMock.presenterWasCalled)
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Fetch Notes
    func testPresenterFetchNotesResponse() {
        let expectation = expectation(description: "should send response to presenter")
        workerMock.result = [
            Note(header: "test", body: "", date: Date(), icon: Data()),
            Note()
        ]
        presenterMock.fetchResponse = {
            XCTAssertTrue(self.workerMock.getNotesWasCalled)
            XCTAssertTrue(self.presenterMock.presenterWasCalled)
            XCTAssertTrue(self.presenterMock.responseMock?.notes.count == 2)
            XCTAssertTrue(self.presenterMock.responseMock?.notes[0].header == "test")
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    func testPresenterFetchNotesResponseFalse() {
        let expectation = expectation(description: "should not send response to presenter")

        presenterMock.fetchResponse = {
            XCTAssertTrue(self.workerMock.getNotesWasCalled)
            XCTAssertTrue(self.presenterMock.presenterWasCalled)
            XCTAssertTrue(self.presenterMock.responseMock?.notes.count == 1)
            XCTAssertTrue(self.presenterMock.responseMock?.notes[0].header == "WorkerNote")
            expectation.fulfill()
        }
        sut.fetchNotes(.init())
        wait(for: [expectation], timeout: 1)
    }

    // Perform Notes Removing
    func testPresenterPerformNotesRemovingResponse() {
        sut.notes = dataStoreMock.notes
        sut.performNotesRemoving(.init(indicesToRemove: [0]))

        XCTAssertTrue(self.dataStoreMock.dataStoreWasCalled)
        XCTAssertTrue(self.presenterMock.presenterWasCalled)
        XCTAssertTrue(self.presenterMock.responseNotesRemovingMock?.indicesToRemove == [0])
    }

    func testPresenterPerformNotesRemovingResponseFalse() {
        sut.performNotesRemoving(.init(indicesToRemove: []))

        XCTAssertTrue(self.dataStoreMock.dataStoreWasCalled)
        XCTAssertTrue(self.presenterMock.presenterWasCalled)
        XCTAssertTrue(self.presenterMock.responseNotesRemovingMock?.indicesToRemove.isEmpty != nil)
    }
}
