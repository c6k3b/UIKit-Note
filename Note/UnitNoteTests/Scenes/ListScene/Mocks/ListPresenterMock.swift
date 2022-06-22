import Foundation
@testable import Note

final class ListPresenterMock: ListPresentationLogic {
    var presenterWasCalled = false
    var responseMock: ListModel.PresentList.Response?
    var fetchResponse: (() -> Void)?

    func presentNotes(_ response: ListModel.PresentList.Response) {
        presenterWasCalled = true
        responseMock = response
        fetchResponse?()
    }

    func presentNoSelectionAlert(_ response: ListModel.Alert.Response) {
    }
}
