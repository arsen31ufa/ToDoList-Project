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
