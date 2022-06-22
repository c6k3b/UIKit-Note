import Foundation
@testable import Note

final class ListPresenterMock: ListPresentationLogic {
    func presentNotes(_ response: ListModel.PresentList.Response) {
    }

    func presentNoSelectionAlert(_ response: ListModel.Alert.Response) {
    }
}
