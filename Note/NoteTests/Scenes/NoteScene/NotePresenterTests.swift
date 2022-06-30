import XCTest
@testable import Note

final class NotePresenterTests: XCTestCase {
    // MARK: - Props
    var sut: NotePresentationLogic!
    var noteViewControllerMock: NoteViewControllerMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        noteViewControllerMock = NoteViewControllerMock()
        sut = NotePresenter()
    }

    override func tearDown() {
        sut = nil
        noteViewControllerMock = nil
        super.tearDown()
    }
    // MARK: - Test Methods

}
