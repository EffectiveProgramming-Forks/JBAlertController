//
//  UIButton.swift
//  Pods
//
//  Created by Jeff Breunig on 11/27/16.
//
//

import UIKit

extension UIButton {
    func setTitleProperties(
        translatesAutoresizingMaskIntoConstraints: Bool? = false,
        text: String? = nil,
        font: UIFont? = nil,
        titleColor: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        contentEdgeInsets: UIEdgeInsets? = nil,
        targetForTouchUpInside target: AnyObject? = nil,
        actionForTouchUpInside action: Selector? = nil,
        tag: Int? = nil
        ) {
        if let translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        }
        if let text = text {
            self.setTitle(text, for: .normal)
        }
        if let font = font {
            self.titleLabel?.font = font
        }
        if let titleColor = titleColor {
            self.setTitleColor(titleColor, for: .normal)
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let lineBreakMode = lineBreakMode {
            self.titleLabel?.lineBreakMode = lineBreakMode
        }
        if let contentEdgeInsets = contentEdgeInsets {
            self.contentEdgeInsets = contentEdgeInsets
        }
        if let target = target, let action = action {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
        if let tag = tag {
            self.tag = tag
        }
    }
}
