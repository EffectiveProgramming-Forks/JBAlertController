//
//  JBAlertView.swift
//  Pods
//
//  Created by Jeff Breunig on 11/27/16.
//
//

import UIKit

public enum JBAlertButtonType {
    case defaultType
    case continueType
    case cancelType
}

public class JBAlertViewButton: UIButton {
    var handler: (() -> Void)?
    var type: JBAlertButtonType = .defaultType
}

class JBAlertView: UIView {
    var dismissHandler: (() -> TimeInterval)?
    var buttons: [JBAlertViewButton] = []

    //MARK: Designated initializer
    
    init(backgroundColor: UIColor, dismissHandler: @escaping (() -> TimeInterval)) {
        super.init(frame: CGRect.zero)
        self.dismissHandler = dismissHandler
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 5
    }

    func addButton(_ title: String,
                   titleColor: UIColor,
                   font: UIFont,
                   backgroundColor: UIColor,
                   type: JBAlertButtonType,
                   handler: @escaping (() -> Void)) {
        let button = JBAlertViewButton()
        button.handler = handler
        button.type = type
        button.setTitleProperties(
            text: title,
            font: font,
            titleColor: titleColor,
            backgroundColor: backgroundColor,
            targetForTouchUpInside: self,
            actionForTouchUpInside: #selector(didTapButton(button:))
        )
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.layer.cornerRadius = 2
        buttons.append(button)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use designated initializer!")
    }
    
    //MARK: Button events
    
    func didTapButton(button: JBAlertViewButton) {
        let delay = dismissHandler?() ?? 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            button.handler?()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: Constraints
    
    func setupConstraints() {
        
        for (index, button) in buttons.enumerated() {
            if index == 0 {
                addConstraint(item: button,
                              attribute: .top,
                              relatedBy: .equal,
                              toItem: self,
                              attribute: .top,
                              constant: Defaults.Layout.AlertView.buttonTopMargin)
            }
            if index == buttons.count - 1 {
                addConstraint(item: button,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: self,
                              attribute: .bottom,
                              constant: -Defaults.Layout.AlertView.buttonBottomMargin)
            } else if index == buttons.count - 2 &&
                (buttons[index + 1].type == .continueType || buttons[index + 1].type == .cancelType) {
                addConstraint(item: button,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: buttons[index + 1],
                              attribute: .top,
                              constant: -Defaults.Layout.AlertView.buttonBottomMargin)
            } else {
                addConstraint(item: button,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: buttons[index + 1],
                              attribute: .top,
                              constant: -Defaults.Layout.AlertView.buttonYSpacing)
            }
            addConstraint(item: button,
                          attribute: .leading,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: .leading,
                          constant: Defaults.Layout.AlertView.buttonXMargin)
            
            addConstraint(item: button,
                          attribute: .trailing,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: .trailing,
                          constant: -Defaults.Layout.AlertView.buttonXMargin)
            button.setHeight(Defaults.Layout.AlertView.buttonHeight)
        }
        super.updateConstraints()
    }
}
