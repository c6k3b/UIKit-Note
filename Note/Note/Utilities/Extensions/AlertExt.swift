import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: actionTitle, style: .cancel)

        alert.addAction(action)
        present(alert, animated: true)
    }
}
