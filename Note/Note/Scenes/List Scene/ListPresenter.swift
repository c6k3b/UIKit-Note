import UIKit

final class ListPresenter: ListPresentationLogic {
    weak var view: ListDisplayLogic?

    func presentNotes(_ response: ListModel.PresentList.Response) {
        var presentedNotes: [ListModel.PresentList.ViewModel.PresentedNote] = []
        for note in response.notes {
            let presentedNote = ListModel.PresentList.ViewModel.PresentedNote(
                header: note.header ?? "",
                body: note.body ?? "",
                date: (note.date ?? Date()).getFormattedDate(format: "dd MM yyyy"),
                icon: UIImage(data: note.icon ?? Data()) ?? UIImage()
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
