//
//  Label+TextView.swift
//  TodoListApp
//
//  Created by Have Dope on 02.09.2024.
//

import Foundation
import UIKit

extension UILabel {
    func setStrikethrough(_ text: String, isCompleted: Bool) {
        let attributes: [NSAttributedString.Key: Any]
        if isCompleted {
            attributes = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.gray
            ]
        } else {
            attributes = [
                .foregroundColor: UIColor.black
            ]
        }
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}

import UIKit

extension UITextView {
    func setStrikethrough(_ text: String, isCompleted: Bool) {
        let attributes: [NSAttributedString.Key: Any]
        if isCompleted {
            attributes = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.gray
            ]
        } else {
            attributes = [
                .foregroundColor: UIColor.gray
            ]
        }
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}
