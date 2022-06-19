import UIKit

enum ListAssembly {
    static func build() -> UIViewController {
        let presenter = ListPresenter()
        let worker = ListWorker()
        let interactor = ListInteractor(presenter: presenter, worker: worker)
        let router = ListRouter(dataStore: interactor)
        let viewController = ListViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}

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
