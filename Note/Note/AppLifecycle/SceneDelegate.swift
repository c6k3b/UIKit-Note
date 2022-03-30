import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Props
    var window: UIWindow?
    private let mainViewController = MainViewController()
    private let navigationController = UINavigationController()
    var note = Note()

    // MARK: - Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow.init(windowScene: windowScene)
        
        navigationController.viewControllers = [mainViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        DispatchQueue.global(qos: .background).async {
//            if let note = self.repository.getNote() {
            self.note.loadData()
//            }
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        DispatchQueue.global(qos: .background).async {
//            if let note = self.repository.note {
            self.note.saveData()
//            }
        }
    }
}
