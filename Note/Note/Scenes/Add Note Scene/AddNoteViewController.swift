import UIKit

final class AddNoteViewController: UIViewController, AddNoteDisplayLogic {
    private let interactor: AddNoteBusinessLogic
    private let router: AddNoteRoutingLogic

    init(interactor: AddNoteBusinessLogic, router: AddNoteRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
    }

    // MARK: - DisplayLogic

    func displayNote(_ viewModel: AddNoteModel.InitForm.ViewModel) {}

    // MARK: - Private

    private func initForm() {
        interactor.requestNote(AddNoteModel.InitForm.Request())
    }
}
