import UIKit

final class ListPresenter: ListPresentationLogic {
    weak var view: ListDisplayLogic?

    func presentNotes(_ response: ListModel.PresentList.Response) {
        var presentedNotes: [ListModel.PresentList.ViewModel.PresentedNoteCell] = []
        for cell in response.notes {
            let presentedNote = ListModel.PresentList.ViewModel.PresentedNoteCell(
                header: cell.header ?? "",
                body: cell.body ?? "",
                date: (cell.date ?? Date()).getFormattedDate(format: "dd MM yyyy"),
                icon: UIImage(data: cell.icon ?? Data()) ?? UIImage()
            )
            presentedNotes.append(presentedNote)
        }

        let viewModel = ListModel.PresentList.ViewModel(
            presentedCells: presentedNotes
        )
        view?.displayNotes(viewModel)
    }

    func presentNoSelectionAlert(_ response: ListModel.Alert.Response) {
        let viewModel = ListModel.Alert.ViewModel(
            title: "Вы не выбрали ни одной заметки",
            message: "",
            actionTitle: "Ok"
        )
        view?.displayNoSelectionAlert(viewModel)
    }
}
