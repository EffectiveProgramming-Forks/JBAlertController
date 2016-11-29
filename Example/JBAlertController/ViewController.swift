//
//  ViewController.swift
//  JBAlertController
//
//  Created by Jeff Breunig on 11/27/2016.
//  Copyright (c) 2016 Jeff Breunig. All rights reserved.
//

import JBAlertController
import SafariServices

enum Device: Int {
    case iPhone7 = 0
    case samsungGalaxyS7
    case pixel
    case lGG5
    case motorolaMotoZ
    
    var title: String {
        switch self {
        case .iPhone7: return "iPhone 7"
        case .samsungGalaxyS7: return "Samsung Galaxy S7"
        case .pixel: return "Pixel"
        case .lGG5: return "LG G5"
        case .motorolaMotoZ: return "Motorola Moto Z"
        }
    }
    
    var urlString: String {
        switch self {
        case .iPhone7: return "http://www.apple.com/shop/buy-iphone/iphone-7"
        case .samsungGalaxyS7: return "http://www.samsung.com/us/explore/galaxy-s7-features-and-specs/?cid=ppc-"
        case .pixel: return "https://store.google.com/product/pixel_phone"
        case .lGG5: return "http://www.lg.com/us/mobile-phones/g5"
        case .motorolaMotoZ: return "https://www.motorola.com/us/products/moto-z"
        }
    }
}

class ViewController: UIViewController {
    let backgroundColor = UIColor(red: 69/255, green: 123/255, blue: 157/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(addAlertView), with: nil, afterDelay: 1)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addAlertView() {
        let titleColor = UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1)
        let alertViewBackgroundColor = UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1)
        let buttonColor = UIColor(red: 29/255, green: 53/255, blue: 187/255, alpha: 1)
        let cancelButtonColor = UIColor(red: 230/255, green: 57/255, blue: 70/255, alpha: 1)
        
        let alertController = JBAlertController.alert(type: .titleOutside,
                                                      title: "Devices",
                                                      secondaryTitle: "Select a device",
                                                      titleColor: titleColor,
                                                      secondaryTitleColor: titleColor,
                                                      alertViewTopMargin: 50,
                                                      backgroundColor: backgroundColor,
                                                      alertViewBackgroundColor: alertViewBackgroundColor)
        alertController.addButton(Device.iPhone7.title, titleColor: titleColor, backgroundColor: buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.iPhone7.urlString)
        }
        alertController.addButton(Device.samsungGalaxyS7.title, titleColor: titleColor, backgroundColor: buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.samsungGalaxyS7.urlString)
        }
        alertController.addButton(Device.pixel.title, titleColor: titleColor, backgroundColor: buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.pixel.urlString)
        }
        alertController.addButton(Device.lGG5.title, titleColor: titleColor, backgroundColor: buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.lGG5.urlString)
        }
        alertController.addButton(Device.motorolaMotoZ.title, titleColor: titleColor, backgroundColor: buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.motorolaMotoZ.urlString)
        }
        alertController.addCancelButton(titleColor: titleColor, backgroundColor: cancelButtonColor) {
            [unowned self] in
            self.addAlertView()
        }
        alertController.show()
    }
    
    private func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            let viewController = SFSafariViewController(url: url)
            self.present(viewController, animated: true, completion: nil)
        }
    }
}

