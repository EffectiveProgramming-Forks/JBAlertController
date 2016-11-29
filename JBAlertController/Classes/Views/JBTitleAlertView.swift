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
                                 alpha: 0)
        addSubview(titleLabel)
        secondaryTitleLabel.setProperties(text: secondaryTitle,
                                          font: secondaryTitleFont,
                                          textColor: secondaryTitleColor,
                                          backgroundColor: UIColor.clear,
                                          textAlignment: .center,
                                          numberOfLines: 0,
                                          alpha: 0)
        addSubview(secondaryTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constraints
    
    override func setupConstraints() {
        setupLabelConstraints()

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
                              toItem: secondaryTitleLabel,
                              attribute: .bottom,
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

    private func setupLabelConstraints() {
        let views = ["titleLabel": titleLabel,
                     "secondaryTitleLabel": secondaryTitleLabel]
        addVFLConstraints([
            "H:|-\(Defaults.Layout.xMargin)-[titleLabel(\(Defaults.Layout.titleLabelWidth))]-\(Defaults.Layout.xMargin)-|",
            "H:|-\(Defaults.Layout.xMargin)-[secondaryTitleLabel]-\(Defaults.Layout.xMargin)-|"], views: views)
        addConstraint(item: titleLabel,
                      attribute: .top,
                      relatedBy: .equal,
                      toItem: self,
                      attribute: .top,
                      constant: Defaults.Layout.titleLabelTopMargin)
        addConstraint(item: secondaryTitleLabel,
                      attribute: .top,
                      relatedBy: .equal,
                      toItem: titleLabel,
                      attribute: .bottom,
                      constant: Defaults.Layout.titleLabelBottomMargin)
        if buttons.isEmpty {
            addConstraint(item: secondaryTitleLabel,
                          attribute: .bottom,
                          relatedBy: .equal,
                          toItem: self,
                          attribute: .bottom,
                          constant: -20)
        }
    }
}
