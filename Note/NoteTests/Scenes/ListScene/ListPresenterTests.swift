import XCTest
@testable import Note

final class ListPresenterTests: XCTestCase {
    // MARK: - Props
    var sut: ListPresentationLogic!
    var listViewControllerMock: ListViewControllerMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        listViewControllerMock = ListViewControllerMock()
        sut = ListPresenter()
    }

    override func tearDown() {
        sut = nil
        listViewControllerMock = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func testViewControllerDisplayNotesWasCalled() {
        sut.presentNotes(.init(notes: [Note()]))
        XCTAssertTrue(listViewControllerMock.viewControllerWasCalled)
    }

    func testViewControllerDisplayNotesRemovingsWasCalled() {
        sut.presentNotesRemoving(.init(indicesToRemove: [0]))
        XCTAssertTrue(listViewControllerMock.viewControllerWasCalled)
    }
//
//    // Present Notes
//    func testPresentNotes() {
//    }
//
//    func testPresentNotesFalse() {
//    }
//
//    // Present Notes Removing
//    func testPresentNotesRemoving() {
//    }
//
//    func testPresentNotesRemovingFalse() {
//    }
}
