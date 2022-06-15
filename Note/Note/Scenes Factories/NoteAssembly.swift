import UIKit

enum NoteAssembly {
    static func build() -> UIViewController {
        let presenter = NotePresenter()
        let worker = NoteWorker()
        let interactor = NoteInteractor(presenter: presenter, worker: worker)
        let router = NoteRouter(dataStore: interactor)
        let viewController = NoteViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
