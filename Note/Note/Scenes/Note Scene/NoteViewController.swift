import UIKit

final class NoteViewController: UIViewController, NoteDisplayLogic {
    private let interactor: NoteBusinessLogic
    private let router: NoteRoutingLogic

    init(interactor: NoteBusinessLogic, router: NoteRoutingLogic) {
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

    func displayNote(_ viewModel: NoteModel.InitForm.ViewModel) {}

    // MARK: - Private

    private func initForm() {
        interactor.requestNote(NoteModel.InitForm.Request())
    }
}
