import Foundation
import UIKit

final class NotesListPresenter: NotesListPresentationLogic {
    weak var view: NotesListDisplayLogic?

    func presentInitForm(_ response: NotesListModels.InitForm.Response) {
        view?.displayInitForm(
            NotesListModels.InitForm.ViewModel(
                header: "",
                body: "",
                date: "",
                icon: UIImage()
            )
        )
    }
}
