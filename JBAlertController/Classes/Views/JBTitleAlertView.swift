//
//  JBTitleAlertView.swift
//  Pods
//
//  Created by Jeff Breunig on 11/28/16.
//
//

class JBTitleAlertView: JBAlertView {
    private let titleLabel = UILabel()
    private let secondaryTitleLabel = UILabel()
    
    //MARK: Designated initializer
    
    init(backgroundColor: UIColor,
         title: String,
         secondaryTitle: String,
         titleFont: UIFont,
         titleColor: UIColor,
         secondaryTitleFont: UIFont,
         secondaryTitleColor: UIColor,
         dismissHandler: @escaping (() -> TimeInterval)) {
        super.init(backgroundColor: backgroundColor, dismissHandler: dismissHandler)
        titleLabel.setProperties(text: title,
                                 font: titleFont,
                                 textColor: titleColor,
                                 backgroundColor: UIColor.clear,
                                 textAlignment: .center,
                                 numberOfLines: 0,
                                 alpha: 1)
        addSubview(titleLabel)
        secondaryTitleLabel.setProperties(text: secondaryTitle,
                                          font: secondaryTitleFont,
                                          textColor: secondaryTitleColor,
                                          backgroundColor: UIColor.clear,
                                          textAlignment: .center,
                                          numberOfLines: 0,
                                          alpha: 1)
        addSubview(secondaryTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use designated initializer!")
    }
    
    //MARK: Constraints
    
    override func setupConstraints() {
        setupLabelConstraints()

        for (index, button) in buttons.enumerated() {
            if index == 0 {
                addConstraint(item: button,
                              attribute: .top,
                              relatedBy: .equal,
                              toItem: secondaryTitleLabel,
                              attribute: .bottom,
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

    private func setupLabelConstraints() {
        let views = ["titleLabel": titleLabel,
                     "secondaryTitleLabel": secondaryTitleLabel]
        addVFLConstraints([
            "H:|-\(Defaults.Layout.AlertView.titleLabelXMargin)-[titleLabel]-\(Defaults.Layout.AlertView.titleLabelXMargin)-|",
            "H:|-\(Defaults.Layout.AlertView.titleLabelXMargin)-[secondaryTitleLabel]-\(Defaults.Layout.AlertView.titleLabelXMargin)-|"], views: views)
        addConstraint(item: titleLabel,
                      attribute: .top,
                      relatedBy: .equal,
                      toItem: self,
                      attribute: .top,
                      constant: Defaults.Layout.AlertView.titleLabelTopMargin)
        addConstraint(item: secondaryTitleLabel,
                      attribute: .top,
                      relatedBy: .equal,
                      toItem: titleLabel,
                      attribute: .bottom,
                      constant: Defaults.Layout.AlertController.titleLabelBottomMargin)
        if buttons.isEmpty {
            addConstraint(item: secondaryTitleLabel,
                          attribute: .bottom,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: .bottom,
                          constant: -Defaults.Layout.AlertView.buttonBottomMargin)
        }
    }
}
