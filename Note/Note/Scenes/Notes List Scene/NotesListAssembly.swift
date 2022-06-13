import Foundation
import UIKit

enum NotesListAssembly {
    static func build() -> UIViewController {
        let presenter = NotesListPresenter()
        let worker = NotesListWorker()
        let interactor = NotesListInteractor(presenter: presenter, worker: worker)
        let router = NotesListRouter(dataStore: interactor)
        let viewController = NotesListViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
