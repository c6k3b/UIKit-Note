import UIKit

final class ListPresenter: ListPresentationLogic {
    weak var view: ListDisplayLogic?

    func presentNotes(_ response: ListModel.Response) {
        var presentedNotes: [ListModel.ViewModel.PresentedNoteCell] = []
        for cell in response.notes {
            let presentedNote = ListModel.ViewModel.PresentedNoteCell(
                header: cell.header ?? "",
                body: cell.body ?? "",
                date: (cell.date ?? Date()).getFormattedDate(format: "dd MM yyyy"),
                icon: UIImage(data: cell.icon ?? Data()) ?? UIImage()
            )
            presentedNotes.append(presentedNote)
        }

        let viewModel = ListModel.ViewModel(
            presentedCells: presentedNotes
        )

        view?.displayNotes(viewModel)
    }
}
