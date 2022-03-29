import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Props
    var window: UIWindow?
    private let mainViewController = MainViewController()
    private let navigationController = UINavigationController()
    private let repository = Repository()

    // MARK: - Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow.init(windowScene: windowScene)
        
        mainViewController.repository = Repository()
        repository.note = Note()
        repository.files = FileSystemOperations()
        
        navigationController.viewControllers = [mainViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
