//
//  Design+View.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation
import UIKit

struct DesignConstans{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

protocol Designable {
    func setUp()
    func addSubViews()
    func makeConstrains()
}

extension Designable where Self: UIView {
    func setUp() {}
    func addSubViews() {}
    func makeConstrains() {}
}


extension UIView{
    func shakeView() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
