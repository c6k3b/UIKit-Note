import XCTest
@testable import Note

final class ListInteractorTests: XCTestCase {
    var sut: ListBusinessLogic!

    var presenterMock: ListPresenterMock!
    var workerMock: ListWorkerMock!

    override func setUp() {
        super.setUp()
        presenterMock = ListPresenterMock()
        workerMock = ListWorkerMock()
        sut = ListInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDown() {
        sut = nil
        presenterMock = nil
        workerMock = nil
        super.tearDown()
    }

    func testWorkerWasCalled() {
        sut.request(.init())
        XCTAssertTrue(workerMock.getNotesWasCalled, "interactor should call the worker method")
    }

    func testPresenterWasCalled() {
        let expectation = expectation(description: "interactor should call presenter method")
        presenterMock.fetchResponse = {
            XCTAssert(self.presenterMock.presenterWasCalled)
            expectation.fulfill()
        }
        sut.request(.init())
        wait(for: [expectation], timeout: 1)
    }

    func testWorkerResponse() {
        let expectation = expectation(description: "should send correct response to presenter")
//        workerMock.result = true
        presenterMock.fetchResponse = {
            XCTAssertTrue(self.presenterMock.presenterWasCalled)
            XCTAssertTrue(self.workerMock.getNotesWasCalled)
            XCTAssertTrue(self.presenterMock.responseMock?.notes != nil)
            expectation.fulfill()
        }
        sut.request(.init())
        wait(for: [expectation], timeout: 1)
    }
}
