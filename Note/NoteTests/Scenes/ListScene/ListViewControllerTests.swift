import XCTest
@testable import Note

final class ListViewControllerTests: XCTestCase {
    // MARK: - Props
    private var sut: ListViewController!
    private var interactor: ListInteractorMock!
    private var router: ListRouter!
    private var dataStore: ListDataStoreMock!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        dataStore = ListDataStoreMock()
        interactor = ListInteractorMock()
        router = ListRouter(dataStore: dataStore)
        sut = ListViewController(interactor: interactor, router: router)
    }

    override func tearDown() {
        dataStore = nil
        interactor = nil
        router = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Methods
    func testShowNotesListShouldCallInteractor() {
        sut.showNotesList()
        XCTAssertTrue(
            interactor.tryToFetchNotes,
            "showNotesList() should call Interactor"
        )
    }

    func testRemoveShouldShouldCallInteractor() {
        sut.remove(indices: nil, cells: nil)
        XCTAssertTrue(
            interactor.tryToPerformNotesRemoving,
            "remove() should call Interactor"
        )
    }

    func testStoreSelectedNoteShouldCallInteractor() {
        sut.tableView(sut.table, didSelectRowAt: IndexPath(index: 0))

        XCTAssertTrue(
            interactor.tryToStoreSelectedNote,
            "table didSelectRow should call Interactor"
        )
    }

    func testInitWithCoder() {
        let viewController = ListViewController(coder: NSCoder())
        let floatingButton = FloatingButton(coder: NSCoder())
        let notesTableView = NotesTableView(coder: NSCoder())
        let noteCell = NoteCell(coder: NSCoder())
        XCTAssertNil(viewController)
        XCTAssertNil(floatingButton)
        XCTAssertNil(notesTableView)
        XCTAssertNil(noteCell)
    }

    func testDisplayNotes() {
        let transmittedData = ListModel.NotesList.ViewModel(
            notes: [
                NoteCell.Model(header: nil, body: nil, date: nil, icon: nil)
            ]
        )
        let expectedResponse = transmittedData.notes

        sut.displayNotes(.init(notes: transmittedData.notes))

        XCTAssertEqual(
            sut.notes,
            expectedResponse,
            "displayNotes() should present NoteCell.Models array"
        )
    }

    func testDisplayNotesRemoving() {
        sut.notes = [
            NoteCell.Model(header: nil, body: nil, date: nil, icon: nil),
            NoteCell.Model(header: nil, body: nil, date: nil, icon: nil)
        ]

        let transmittedData = [0]
        let expectedResponse = sut.notes.count - 1

        sut.displayNotesRemoving(.success(indicesToRemove: transmittedData))

        XCTAssertEqual(
            sut.notes.count,
            expectedResponse,
            "displayNotesRemoving() should display proper notes count"
        )
    }

    func testDisplayNotesRemovingProperNote() {
        sut.notes = [
            NoteCell.Model(header: nil, body: nil, date: nil, icon: nil),
            NoteCell.Model(header: "2", body: nil, date: nil, icon: nil)
        ]

        let transmittedData = [0]
        let expectedResponse = "2"

        sut.displayNotesRemoving(.success(indicesToRemove: transmittedData))

        XCTAssertEqual(
            sut.notes[0].header,
            expectedResponse,
            "displayNotesRemoving() should display proper notes count"
        )
    }

    func testDisplayAlert() {
        let transmittedData = ListModel.NotesRemoving.ViewModel.Alert(
            title: Styles.AlertNoSelectionForDeleteNotes.title,
            message: Styles.AlertNoSelectionForDeleteNotes.message,
            actionTitle: Styles.AlertNoSelectionForDeleteNotes.actionTitle
        )
        let expectedResponse = UIAlertController(
            title: Styles.AlertNoSelectionForDeleteNotes.title,
            message: Styles.AlertNoSelectionForDeleteNotes.message,
            preferredStyle: .alert
        )

        sut.displayNotesRemoving(.failure(alert: transmittedData))

        XCTAssertEqual(
            transmittedData.title,
            expectedResponse.title,
            "displayNotes() should show an alert"
        )
        XCTAssertEqual(
            transmittedData.message,
            expectedResponse.message,
            "displayNotes() should show an alert"
        )
    }
}

// MARK: - Mocks
private final class ListInteractorMock: ListBusinessLogic {
    var tryToFetchNotes = false
    var tryToPerformNotesRemoving = false
    var tryToStoreSelectedNote = false

    func fetchNotes(_ request: ListModel.NotesList.Request) {
        tryToFetchNotes = true
    }

    func performNotesRemoving(_ request: ListModel.NotesRemoving.Request) {
        tryToPerformNotesRemoving = true
    }

    func storeSelectedNote(_ index: Int?) {
        tryToStoreSelectedNote = true
    }
}

private final class ListDataStoreMock: ListDataStore {
    var notes: [Note] = [Note(header: "ListNote", body: nil, date: nil, icon: nil)]
    var note: Note = Note(header: "Note", body: nil, date: nil, icon: nil)
}
