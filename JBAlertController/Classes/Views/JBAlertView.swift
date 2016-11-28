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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
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
        let x: CGFloat = 10
        let top: CGFloat = 20
        let bottom: CGFloat = 20
        let ySpacing: CGFloat = 10
        let height: CGFloat = 50
        for (index, button) in buttons.enumerated() {
            if index == 0 {
                addConstraint(item: button,
                              attribute: .top,
                              relatedBy: .equal,
                              toItem: self,
                              attribute: .top,
                              constant: top)
            }
            if index == buttons.count - 1 {
                addConstraint(item: button,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: self,
                              attribute: .bottom,
                              constant: -bottom)
            } else if index == buttons.count - 2 &&
                (buttons[index + 1].type == .continueType || buttons[index + 1].type == .cancelType) {
                addConstraint(item: button,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: buttons[index + 1],
                              attribute: .top,
                              constant: -bottom)
            } else {
                addConstraint(item: button,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: buttons[index + 1],
                              attribute: .top,
                              constant: -ySpacing)
            }
            addConstraint(item: button,
                          attribute: .leading,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: .leading,
                          constant: x)
            
            addConstraint(item: button,
                          attribute: .trailing,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: .trailing,
                          constant: -x)
            button.setHeight(height)
        }
        super.updateConstraints()
    }
}
