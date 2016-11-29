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

struct Config {
    var type: JBAlertControllerType
    var alertViewTopMargin: CGFloat
    var titleColor: UIColor
    var buttonTitleColor: UIColor
    var alertViewBackgroundColor: UIColor
    var buttonColor: UIColor
    var cancelButtonColor: UIColor
    var backgroundColor: UIColor
}

class ViewController: UIViewController {
    var isTitleOutside = true
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 69/255, green: 123/255, blue: 157/255, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(addAlertView), with: nil, afterDelay: 1)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getConfig() -> Config {
        let config: Config
        if isTitleOutside {
            config = Config(type: .titleOutside,
                            alertViewTopMargin: 50,
                            titleColor: UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1),
                            buttonTitleColor: UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1),
                            alertViewBackgroundColor: UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1),
                            buttonColor: UIColor(red: 29/255, green: 53/255, blue: 187/255, alpha: 1),
                            cancelButtonColor: UIColor(red: 230/255, green: 57/255, blue: 70/255, alpha: 1),
                            backgroundColor: UIColor(red: 69/255, green: 123/255, blue: 157/255, alpha: 1))
        } else {
            config = Config(type: .titleInside,
                            alertViewTopMargin: 80,
                            titleColor: UIColor(red: 80/255, green: 81/255, blue: 79/255, alpha: 1),
                            buttonTitleColor: UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1),
                            alertViewBackgroundColor: UIColor(red: 241/255, green: 250/255, blue: 238/255, alpha: 1),
                            buttonColor: UIColor(red: 36/255, green: 123/255, blue: 160/255, alpha: 1),
                            cancelButtonColor: UIColor(red: 242/255, green: 95/255, blue: 92/255, alpha: 1),
                            backgroundColor: UIColor(red: 112/255, green: 193/255, blue: 179/255, alpha: 1))
        }
        view.backgroundColor = config.backgroundColor
        isTitleOutside = !isTitleOutside
        return config
    }
    
    func addAlertView() {
        let config = getConfig()
        let alertController = JBAlertController.alert(type: config.type,
                                                      title: "Devices",
                                                      secondaryTitle: "Select a device",
                                                      titleColor: config.titleColor,
                                                      secondaryTitleColor: config.titleColor,
                                                      alertViewTopMargin: config.alertViewTopMargin,
                                                      backgroundColor: config.backgroundColor,
                                                      alertViewBackgroundColor: config.alertViewBackgroundColor)
        alertController.addButton(Device.iPhone7.title, titleColor: config.buttonTitleColor, backgroundColor: config.buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.iPhone7.urlString)
        }
        alertController.addButton(Device.samsungGalaxyS7.title, titleColor: config.buttonTitleColor, backgroundColor: config.buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.samsungGalaxyS7.urlString)
        }
        alertController.addButton(Device.pixel.title, titleColor: config.buttonTitleColor, backgroundColor: config.buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.pixel.urlString)
        }
        alertController.addButton(Device.lGG5.title, titleColor: config.buttonTitleColor, backgroundColor: config.buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.lGG5.urlString)
        }
        alertController.addButton(Device.motorolaMotoZ.title, titleColor: config.buttonTitleColor, backgroundColor: config.buttonColor) {
            [unowned self] in
            self.openURL(urlString: Device.motorolaMotoZ.urlString)
        }
        alertController.addCancelButton(titleColor: config.buttonTitleColor, backgroundColor: config.cancelButtonColor) {
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

