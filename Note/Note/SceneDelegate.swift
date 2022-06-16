import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)

        navigationController = UINavigationController()
        navigationController?.viewControllers = [ListAssembly.build()]

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
