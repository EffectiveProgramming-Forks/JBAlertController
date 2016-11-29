//
//  JBAlertController.swift
//  Pods
//
//  Created by Jeff Breunig on 11/27/16.
//
//

import UIKit

public enum JBAlertControllerType {
    case titleInside
    case titleOutside
}

@objc protocol JBAlertControllerDelegate: class {
    func setupConstraints()
    @objc optional func addScrollViewLabelSubviews()
    @objc optional func animateShowScrollViewLabels()
    @objc optional func hideScrollViewLabels()
}

public class JBAlertController: UIViewController {
    var alertView: JBAlertView!
    var alertViewTopMargin: CGFloat = Defaults.Layout.AlertController.alertViewTopMargin
    let scrollView = UIScrollView()
    var topConstraint: NSLayoutConstraint!
    var backgroundColor: UIColor = Defaults.Color.background
    let hideOffset = UIScreen.main.bounds.height + 100
    weak var delegate: JBAlertControllerDelegate?
    
    public static func alert(type: JBAlertControllerType,
                title: String,
                secondaryTitle: String,
                titleFont: UIFont = Defaults.Font.title,
                titleColor: UIColor = Defaults.Color.title,
                secondaryTitleFont: UIFont = Defaults.Font.secondaryTitle,
                secondaryTitleColor: UIColor = Defaults.Color.secondaryTitle,
                alertViewTopMargin: CGFloat = Defaults.Layout.AlertController.alertViewTopMargin,
                backgroundColor: UIColor = Defaults.Color.background,
                alertViewBackgroundColor: UIColor = Defaults.Color.alertViewBackground) -> JBAlertController {
        if type == .titleInside {
            let controller = JBTitleInsideAlertController(title: title,
                                                           secondaryTitle: secondaryTitle,
                                                           titleFont: titleFont,
                                                           titleColor: titleColor,
                                                           secondaryTitleFont: secondaryTitleFont,
                                                           secondaryTitleColor: secondaryTitleColor,
                                                           alertViewTopMargin: alertViewTopMargin,
                                                           backgroundColor: backgroundColor,
                                                           alertViewBackgroundColor: alertViewBackgroundColor)
            return controller
        } else {
            let controller = JBTitleOutsideAlertController(title: title,
                                                           secondaryTitle: secondaryTitle,
                                                           titleFont: titleFont,
                                                           titleColor: titleColor,
                                                           secondaryTitleFont: secondaryTitleFont,
                                                           secondaryTitleColor: secondaryTitleColor,
                                                           alertViewTopMargin: alertViewTopMargin,
                                                           backgroundColor: backgroundColor,
                                                           alertViewBackgroundColor: alertViewBackgroundColor)
            return controller
        }
    }
    
    //MARK: Designated initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("Use designated initializer!")
    }
    
    //MARK: Setup views
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        delegate?.setupConstraints()
        view.layoutIfNeeded()
    }
    
    private func setupSubviews() {
        setupScrollView()
        scrollView.addSubview(alertView)
        delegate?.addScrollViewLabelSubviews?()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = backgroundColor
        view.addSubview(scrollView)
    }
    
    private func setupAlertView() {
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
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
    
    //MARK: Show AlertView
    
    public func show() {
        alertView.setupConstraints()
        alertView.layoutIfNeeded()
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(view)
        }
        animateShowViews()
    }
    
    private func animateShowViews() {
        delegate?.animateShowScrollViewLabels?()
        topConstraint.constant = alertViewTopMargin
        UIView.animate(withDuration: Defaults.Animate.AlertView.Show.duration, delay: Defaults.Animate.AlertView.Show.delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    //MARK: Hide AlertView

    func hide() {
        topConstraint.constant = hideOffset
        UIView.animate(withDuration: Defaults.Animate.AlertView.Hide.duration, delay: Defaults.Animate.AlertView.Hide.delay, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.delegate?.hideScrollViewLabels?()
            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.view.removeFromSuperview()
        })
    }
}
