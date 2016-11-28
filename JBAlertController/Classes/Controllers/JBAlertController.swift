//
//  JBAlertController.swift
//  Pods
//
//  Created by Jeff Breunig on 11/27/16.
//
//

import UIKit

struct Defaults {
    struct Layout {
        static let titleLabelTopMargin: CGFloat = 70
        static let titleLabelBottomMargin: CGFloat = 20
        static let titleLabelWidth: CGFloat = UIScreen.main.bounds.width - (Defaults.Layout.xMargin * 2)
        static let alertViewTopMargin: CGFloat = 50
        static let alertViewBottomMargin: CGFloat = 20
        static let xMargin: CGFloat = 40
    }
    struct Color {
        static let background = UIColor.blue
        static let alertViewBackground = UIColor.white
        static let buttonTitle = UIColor.white
        static let buttonBackground = UIColor.blue
        static let cancelBackground = UIColor.orange
        static let continueBackground = UIColor.orange
        static let cancelButtonBackground = UIColor.orange
        static let continueButtonBackground = UIColor.orange
        static let title = UIColor.white
        static let secondaryTitle = UIColor.white
    }
    struct Font {
        static let title = UIFont.boldSystemFont(ofSize: 18)
        static let secondaryTitle = UIFont.systemFont(ofSize: 16)
        static let button = UIFont.systemFont(ofSize: 16)
    }
}

public class JBAlertController: UIViewController {
    private var alertView: JBAlertView!
    private var alertViewTopMargin: CGFloat = Defaults.Layout.alertViewTopMargin
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let secondaryTitleLabel = UILabel()
    private var topConstraint: NSLayoutConstraint!
    private var backgroundColor: UIColor = Defaults.Color.background
    private let hideViewAnimationDuration: TimeInterval = 0.5
    private let hideOffset = UIScreen.main.bounds.height + 100
    
    // MARK: Designated initializer
    
    public init(title: String,
                secondaryTitle: String,
                titleFont: UIFont = Defaults.Font.title,
                titleColor: UIColor = Defaults.Color.title,
                secondaryTitleFont: UIFont = Defaults.Font.secondaryTitle,
                secondaryTitleColor: UIColor = Defaults.Color.secondaryTitle,
                alertViewTopMargin: CGFloat = Defaults.Layout.alertViewTopMargin,
                backgroundColor: UIColor = Defaults.Color.background,
                alertViewBackgroundColor: UIColor = Defaults.Color.alertViewBackground) {
        super.init(nibName: nil, bundle: nil)
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
        self.alertViewTopMargin = alertViewTopMargin
        alertView = JBAlertView(backgroundColor: alertViewBackgroundColor, dismissHandler: {
            [unowned self] in
            self.hide()
            return self.hideViewAnimationDuration
        })
        self.backgroundColor = backgroundColor
        view.backgroundColor = backgroundColor
    }
    
    required public init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Use designated initializer!")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        view.layoutIfNeeded()
    }
    
    private func addSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = backgroundColor
        view.addSubview(scrollView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        scrollView.addSubview(alertView)

        scrollView.addSubview(titleLabel)
        scrollView.addSubview(secondaryTitleLabel)
    }

    public func addButton(_ title: String,
                   titleColor: UIColor = Defaults.Color.buttonTitle,
                   font: UIFont = Defaults.Font.button,
                   backgroundColor: UIColor = Defaults.Color.buttonBackground,
                   type: JBAlertButtonType = .defaultType,
                   handler: @escaping (() -> Void)) {
        alertView.addButton(title,
                            titleColor: titleColor,
                            font: font,
                            backgroundColor: backgroundColor,
                            type: type,
                            handler: handler)
    }
    
    public func addContinueButton(titleColor: UIColor = Defaults.Color.buttonTitle,
                          font: UIFont = Defaults.Font.button,
                          backgroundColor: UIColor = Defaults.Color.buttonBackground,
                          handler: @escaping (() -> Void)) {
        alertView.addButton("Continue",
                            titleColor: titleColor,
                            font: font,
                            backgroundColor: backgroundColor,
                            type: .continueType,
                            handler: handler)
    }
    
    public func addCancelButton(titleColor: UIColor = Defaults.Color.buttonTitle,
                                  font: UIFont = Defaults.Font.button,
                                  backgroundColor: UIColor = Defaults.Color.buttonBackground,
                                  handler: @escaping (() -> Void)) {
        alertView.addButton("Cancel",
                            titleColor: titleColor,
                            font: font,
                            backgroundColor: backgroundColor,
                            type: .cancelType,
                            handler: handler)
    }
    
    public func show() {
        alertView.setupConstraints()
        alertView.layoutIfNeeded()
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(view)
        }
        animateShowViews()
    }
    
    private func animateShowViews() {
        UIView.animate(withDuration: 1.0) {
            self.titleLabel.alpha = 1.0
            self.secondaryTitleLabel.alpha = 1.0
        }
        topConstraint.constant = alertViewTopMargin
        UIView.animate(withDuration: 0.6, delay: 0.4, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func hide() {
        topConstraint.constant = hideOffset
        UIView.animate(withDuration: hideViewAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.titleLabel.alpha = 0.0
            self.secondaryTitleLabel.alpha = 0.0
            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.view.removeFromSuperview()
        })
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
        scrollView.addConstraint(item: alertView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, constant: -Defaults.Layout.alertViewBottomMargin)
        scrollView.addVFLConstraints(["V:|-\(Defaults.Layout.titleLabelTopMargin)-[titleLabel]-\(Defaults.Layout.titleLabelBottomMargin)-[secondaryTitleLabel]->=0-|",
            "H:|-\(Defaults.Layout.xMargin)-[alertView]-\(Defaults.Layout.xMargin)-|",
            "H:|-\(Defaults.Layout.xMargin)-[titleLabel(\(Defaults.Layout.titleLabelWidth))]-\(Defaults.Layout.xMargin)-|",
            "H:|-\(Defaults.Layout.xMargin)-[secondaryTitleLabel]-\(Defaults.Layout.xMargin)-|"], views: views)
        super.updateViewConstraints()
    }
}
