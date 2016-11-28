//
//  UILabel.swift
//  Pods
//
//  Created by Jeff Breunig on 11/27/16.
//
//

import UIKit

extension UILabel {
    func setProperties(
        translatesAutoresizingMaskIntoConstraints: Bool? = false,
        text: String? = nil,
        font: UIFont? = nil,
        textColor: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        numberOfLines: Int? = nil,
        horizontalContentCompressionResistancePriority: Float? = nil,
        horizontalContentHuggingPriority: Float? = nil,
        tag: Int? = nil,
        alpha: CGFloat? = nil
        ) {
        if let translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        }
        if let text = text {
            self.text = text
        }
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        if let lineBreakMode = lineBreakMode {
            self.lineBreakMode = lineBreakMode
        }
        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }
        if let priority = horizontalContentCompressionResistancePriority {
            self.setContentCompressionResistancePriority(priority, for: UILayoutConstraintAxis.horizontal)
        }
        if let priority = horizontalContentHuggingPriority {
            self.setContentHuggingPriority(priority, for: UILayoutConstraintAxis.horizontal)
        }
        if let tag = tag {
            self.tag = tag
        }
        if let alpha = alpha {
            self.alpha = alpha 
        }
    }
}
