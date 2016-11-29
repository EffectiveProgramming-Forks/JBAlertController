//
//  JBTitleInsideAlertController.swift
//  Pods
//
//  Created by Jeff Breunig on 11/28/16.
//
//

public class JBTitleInsideAlertController: JBAlertController, JBAlertControllerDelegate {
    
    // MARK: Designated initializer
    
    public init(title: String,
                secondaryTitle: String,
                titleFont: UIFont,
                titleColor: UIColor,
                secondaryTitleFont: UIFont,
                secondaryTitleColor: UIColor,
                alertViewTopMargin: CGFloat,
                backgroundColor: UIColor,
                alertViewBackgroundColor: UIColor) {
        super.init()
        delegate = self
        alertView = JBTitleAlertView(backgroundColor: alertViewBackgroundColor,
                                     title: title,
                                     secondaryTitle: secondaryTitle,
                                     titleFont: titleFont,
                                     titleColor: titleColor,
                                     secondaryTitleFont: secondaryTitleFont,
                                     secondaryTitleColor: secondaryTitleColor,
                                     dismissHandler: {
            self.hide()
            return self.hideViewAnimationDuration
        })
        self.alertViewTopMargin = alertViewTopMargin
        self.backgroundColor = backgroundColor
        view.backgroundColor = backgroundColor
    }
    
    required public init!(coder aDecoder: NSCoder) {
        fatalError("Use designated initializer!")
    }
    
    //MARK: JBAlertControllerDelegate

    func setupConstraints() {
        let views: [String: Any] = ["alertView": alertView]
        
        scrollView.fillSuperview()
        topConstraint = NSLayoutConstraint(item: alertView,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: scrollView,
                                           attribute: .top,
                                           multiplier: 1,
                                           constant: hideOffset)
        scrollView.addConstraint(topConstraint)
        scrollView.addConstraint(item: alertView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, constant: -Defaults.Layout.alertViewBottomMargin)
        scrollView.addVFLConstraint("H:|-\(Defaults.Layout.xMargin)-[alertView]-\(Defaults.Layout.xMargin)-|", views: views)
        super.updateViewConstraints()
    }
}
