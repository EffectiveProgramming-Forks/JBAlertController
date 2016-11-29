//
//  Defaults.swift
//  Pods
//
//  Created by Jeff Breunig on 11/28/16.
//
//

import Foundation

struct Defaults {
    struct Layout {
        struct AlertController {
            static let titleLabelTopMargin: CGFloat = 70
            static let titleLabelBottomMargin: CGFloat = 20
            static let alertViewWidth: CGFloat = UIScreen.main.bounds.width - (Defaults.Layout.AlertController.xMargin * 2)
            static let alertViewTopMargin: CGFloat = 50
            static let alertViewBottomMargin: CGFloat = 20
            static let xMargin: CGFloat = 40
        }
        struct AlertView {
            static let buttonXMargin: CGFloat = 10
            static let buttonTopMargin: CGFloat = 20
            static let buttonBottomMargin: CGFloat = 20
            static let buttonYSpacing: CGFloat = 10
            static let buttonHeight: CGFloat = 50
            static let titleLabelXMargin: CGFloat = 20
            static let titleLabelTopMargin: CGFloat = 30
        }
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
    
    struct Animate {
        struct AlertView {
            struct Show {
                static let duration: TimeInterval = 0.6
                static let delay: TimeInterval = 0.4
            }
            struct Hide {
                static let duration: TimeInterval = 0.5
                static let delay: TimeInterval = 0.0
            }
        }
        struct Title {
            struct Show {
                static let duration: TimeInterval = 1.0
            }
        }
    }
}
