//
//  UIView.swift
//  Pods
//
//  Created by Jeff Breunig on 11/27/16.
//
//

import UIKit

private typealias Layout = UIView
extension Layout {
    
    func addConstraint(item: Any,
                       attribute: NSLayoutAttribute,
                       relatedBy: NSLayoutRelation = .equal,
                       toItem: Any,
                       attribute toAttribute: NSLayoutAttribute,
                       multiplier: CGFloat = 1,
                       constant: CGFloat = 0) {
        addConstraint(NSLayoutConstraint.init(item: item,
                                              attribute: attribute,
                                              relatedBy: relatedBy,
                                              toItem: toItem,
                                              attribute: toAttribute,
                                              multiplier: multiplier,
                                              constant: constant))
    }

    func centerHorizontallyInSuperview(constant: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: superview,
                                                    attribute: .centerX,
                                                    multiplier: 1.0,
                                                    constant: constant))
    }
    
    func alignWithSuperviewTop(constant: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: superview,
                                                    attribute: .top,
                                                    multiplier: 1.0,
                                                    constant: constant))
    }
    
    func setSize(_ size: CGSize) {
        setHeight(size.height)
        setWidth(size.width)
    }
    
    func setHeight(_ height: CGFloat) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: height))
    }
    
    func setWidth(_ width: CGFloat) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: width))
    }
    
    // VFL Constraints
    
    func addVFLConstraint(_ constraint: String,
                          options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0),
                          metrics: [String : Any]? = nil,
                          views: [String : Any] = [:])  {
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: constraint,
                                                        options: options,
                                                        metrics: metrics,
                                                        views: views)
        addConstraints(constraint)
    }
    
    func addVFLConstraints(_ constraints: [String],
                          options: NSLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0),
                          metrics: [String : Any]? = nil,
                          views: [String : Any] = [:])  {
        for string in constraints {
            let constraint = NSLayoutConstraint.constraints(withVisualFormat: string,
                                                            options: options,
                                                            metrics: metrics,
                                                            views: views)
            addConstraints(constraint)
        }
    }
    
    
    func fillSuperview() {
        superview?.addVFLConstraints(["H:|[view]|", "V:|[view]|"], views: ["view": self])
    }
    
    func fillSuperviewWidth() {
        superview?.addVFLConstraint("H:|[view]|", views: ["view": self])
    }
    
    func fillSuperviewHeight() {
        superview?.addVFLConstraint("V:|[view]|", views: ["view": self])
    }
}
