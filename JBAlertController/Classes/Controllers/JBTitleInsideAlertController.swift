//
//  JBTitleInsideAlertController.swift
//  Pods
//
//  Created by Jeff Breunig on 11/28/16.
//
//

class JBTitleInsideAlertController: JBAlertController, JBAlertControllerDelegate {
    
    // MARK: Designated initializer
    
    init(title: String,
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
            return Defaults.Animate.AlertView.Show.duration + Defaults.Animate.AlertView.Show.delay
        })
        alertView.translatesAutoresizingMaskIntoConstraints = false
        self.alertViewTopMargin = alertViewTopMargin
        self.backgroundColor = backgroundColor
        view.backgroundColor = backgroundColor
    }
    
    required init!(coder aDecoder: NSCoder) {
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
        scrollView.addConstraint(item: alertView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, constant: -Defaults.Layout.AlertController.alertViewBottomMargin)
        scrollView.addVFLConstraint("H:|-\(Defaults.Layout.AlertController.xMargin)-[alertView(\(Defaults.Layout.AlertController.alertViewWidth))]-\(Defaults.Layout.AlertController.xMargin)-|", views: views)
        super.updateViewConstraints()
    }
}
