import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-7, 7, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }

    func shakeHorizontaly() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.8
        animation.values = [5, -3, 0]
        layer.add(animation, forKey: "shakeHorizontaly")
    }

    func shakeOnAppear() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.duration = 1
        animation.values = [100, -10, 5, -5, 0]
        layer.add(animation, forKey: "shakeOnAppear")
    }

    func shakeOnDisappear() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 0.8
        animation.values = [0, -10, 100]
        layer.add(animation, forKey: "shakeOnDisappear")
    }
}
