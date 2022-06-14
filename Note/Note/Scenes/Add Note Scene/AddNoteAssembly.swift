import UIKit

enum AddNoteAssembly {
    static func build() -> UIViewController {
        let presenter = AddNotePresenter()
        let worker = AddNoteWorker()
        let interactor = AddNoteInteractor(presenter: presenter, worker: worker)
        let router = AddNoteRouter(dataStore: interactor)
        let viewController = AddNoteViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
