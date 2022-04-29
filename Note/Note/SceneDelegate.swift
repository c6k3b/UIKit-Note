import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let listVC = ListViewController()
    private let navigationController = UINavigationController()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        navigationController.viewControllers = [listVC]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
