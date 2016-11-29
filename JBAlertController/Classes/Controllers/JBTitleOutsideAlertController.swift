//
//  JBTitleOutsideAlertController.swift
//  Pods
//
//  Created by Jeff Breunig on 11/28/16.
//
//

public class JBTitleOutsideAlertController: JBAlertController, JBAlertControllerDelegate {
    private let titleLabel = UILabel()
    private let secondaryTitleLabel = UILabel()
    
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
        titleLabel.setProperties(text: title,
                                 font: titleFont,
                                 textColor: titleColor,
                                 backgroundColor: UIColor.clear,
                                 textAlignment: .center,
                                 numberOfLines: 0,
                                 alpha: 0)
        secondaryTitleLabel.setProperties(text: secondaryTitle,
                                          font: secondaryTitleFont,
                                          textColor: secondaryTitleColor,
                                          backgroundColor: UIColor.clear,
                                          textAlignment: .center,
                                          numberOfLines: 0,
                                          alpha: 0)
        alertView = JBAlertView(backgroundColor: alertViewBackgroundColor, dismissHandler: {
            self.hide()
            return Defaults.Animate.AlertView.Show.duration + Defaults.Animate.AlertView.Show.delay
        })
        alertView.translatesAutoresizingMaskIntoConstraints = false
        self.alertViewTopMargin = alertViewTopMargin
        self.backgroundColor = backgroundColor
        view.backgroundColor = backgroundColor
    }
    
    required public init!(coder aDecoder: NSCoder) {
        fatalError("Use designated initializer!")
    }
    
    //MARK: JBAlertControllerDelegate

    func addScrollViewLabelSubviews() {
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(secondaryTitleLabel)
    }
    
    func animateShowScrollViewLabels() {
        UIView.animate(withDuration: Defaults.Animate.Title.Show.duration) {
            self.titleLabel.alpha = 1.0
            self.secondaryTitleLabel.alpha = 1.0
        }
    }
    
    func hideScrollViewLabels() {
        self.titleLabel.alpha = 0.0
        self.secondaryTitleLabel.alpha = 0.0
    }
    
    func setupConstraints() {
        let views = ["alertView": alertView,
                     "titleLabel": titleLabel,
                     "secondaryTitleLabel": secondaryTitleLabel]
        
        scrollView.fillSuperview()
        topConstraint = NSLayoutConstraint(item: alertView,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: secondaryTitleLabel,
                                           attribute: .bottom,
                                           multiplier: 1,
                                           constant: hideOffset)
        scrollView.addConstraint(topConstraint)
        scrollView.addConstraint(item: alertView,
                                 attribute: .bottom,
                                 relatedBy: .equal,
                                 toItem: scrollView,
                                 attribute: .bottom,
                                 constant: -Defaults.Layout.AlertController.alertViewBottomMargin)
        scrollView.addVFLConstraints(["V:|-\(Defaults.Layout.AlertController.titleLabelTopMargin)-[titleLabel]-\(Defaults.Layout.AlertController.titleLabelBottomMargin)-[secondaryTitleLabel]->=0-|",
            "H:|-\(Defaults.Layout.AlertController.xMargin)-[alertView(\(Defaults.Layout.AlertController.alertViewWidth))]-\(Defaults.Layout.AlertController.xMargin)-|",
            "H:|-\(Defaults.Layout.AlertController.xMargin)-[titleLabel]-\(Defaults.Layout.AlertController.xMargin)-|",
            "H:|-\(Defaults.Layout.AlertController.xMargin)-[secondaryTitleLabel]-\(Defaults.Layout.AlertController.xMargin)-|"], views: views)
        super.updateViewConstraints()
    }
}
