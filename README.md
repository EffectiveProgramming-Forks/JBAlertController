# JBAlertController

[![Version](https://img.shields.io/cocoapods/v/JBAlertController.svg?style=flat)](http://cocoapods.org/pods/JBAlertController)
[![License](https://img.shields.io/cocoapods/l/JBAlertController.svg?style=flat)](http://cocoapods.org/pods/JBAlertController)
[![Platform](https://img.shields.io/cocoapods/p/JBAlertController.svg?style=flat)](http://cocoapods.org/pods/JBAlertController)

![](http://giphy.com/gifs/k6qUPuotbySSk)

**JBAlertController** is a Swift framework that allows the user to display a customizable alert view.

## Requirements

- iOS 10.0+
- Swift 3.0
- Xcode 8.0

## Installation

**JBAlertController** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JBAlertController"
```

## Example

To run the example project, clone the repo, and run the project from the Example directory.

## Usage

```swift
import JBAlertController

let alertController = JBAlertController.alert(type: .titleInside,
                                                      title: "Devices",
                                                      secondaryTitle: "Select a device",
                                                      titleFont: UIFont.boldSystemFont(ofSize: 18),
                                                      titleColor: UIColor.black,
                                                      secondaryTitleFont: UIFont.systemFont(ofSize: 16),
                                                      secondaryTitleColor: UIColor.black,
                                                      alertViewTopMargin: 80,
                                                      backgroundColor: UIColor.blue,
                                                      alertViewBackgroundColor: UIColor.white)

alertController.addButton("iPhone 7", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), backgroundColor: UIColor.blue) {

}

alertController.addButton("Samsung Galaxy S7", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), backgroundColor: UIColor.blue) {

}

alertController.addCancelButton(titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), backgroundColor: UIColor.red) {

}

alertController.show()

```

### JBAlertController Public API                                              

```swift
static func alert(type: JBAlertControllerType,
                title: String,
                secondaryTitle: String,
                titleFont: UIFont,  // default is UIFont.boldSystemFont(ofSize: 18)
                titleColor: UIColor, // default is UIColor.white
                secondaryTitleFont: UIFont, // default is UIFont.systemFont(ofSize: 16)
                secondaryTitleColor: UIColor, // default is UIColor.white
                alertViewTopMargin: CGFloat, // default is 50
                backgroundColor: UIColor, // default is UIColor.blue
                alertViewBackgroundColor: UIColor,  // default is UIColor.white
       			) -> JBAlertController   

enum JBAlertControllerType {
    case titleInside // displays the title and secondary title within the alert view
    case titleOutside // displays the title and secondary title above the alert view
} 

func addButton(_ title: String,
                   titleColor: UIColor, // default is UIColor.white
                   font: UIFont, // default is UIFont.systemFont(ofSize: 16)
                   backgroundColor: UIColor = Defaults.Color.buttonBackground,
                   type: JBAlertButtonType = .defaultType,
                   handler: @escaping (() -> Void))

func addContinueButton(titleColor: UIColor, // default is UIColor.white
                          font: UIFont, // default is UIFont.systemFont(ofSize: 16)
                          backgroundColor: UIColor, // default is UIColor.blue
                          handler: @escaping (() -> Void))

func addCancelButton(titleColor: UIColor, // default is UIColor.white
                                  font: UIFont, // default is UIFont.systemFont(ofSize: 16)
                                  backgroundColor: UIColor, // default is UIColor.blue
                                  handler: @escaping (() -> Void))

func show()

```

## Author

Jeff Breunig, jkbreunig@gmail.com

## License

**JBAlertController** is available under the MIT license. See the LICENSE file for more info.