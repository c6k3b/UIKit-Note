import UIKit

enum ListAssembly {
    static func build() -> UIViewController {
        let presenter = ListPresenter()
        let worker = ListWorker()
        let interactor = ListInteractor(presenter: presenter, worker: worker)
        let router = ListRouter(dataStore: interactor)
        let viewController = ListViewController(interactor: interactor, router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
