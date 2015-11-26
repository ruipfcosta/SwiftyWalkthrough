#SwiftyWalkthrough

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftyWalkthrough.svg)]()
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

SwiftyWalkthrough is a library for creating great walkthrough experiences in your apps, written in Swift. 
You can use the library to allow users to navigate and explore your app, step by step, in a predefined way controlled by you.

SwiftyWalkthrough was developed at [Insane Logic](http://www.insanelogic.co.uk).

##Features

- [x] Add walkthroughs to your app with little effort: you don't need to change anything in your view hierarchy.
- [x] SwiftyWalkthrough is great for onboarding, walkthroughs, tutorials, etc.
- [x] Control with precision which views are accessible to the user in a given time.
- [x] Take users through a series of steps, even across multiple screens.
- [x] Is simple!

##Preview

![SwiftyWalkthrough demo](https://raw.githubusercontent.com/ruipfcosta/SwiftyWalkthrough/master/extras/demo.gif)

##Requirements

* iOS 8.0+
* Xcode 7.0+

##Instalation

###CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwiftyWalkthrough into your Xcode project using CocoaPods, include this in your Podfile:

```ruby
platform :ios, '8.0'
use_frameworks!

pod 'SwiftyWalkthrough'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwiftyWalkthrough into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "ruipfcosta/SwiftyWalkthrough"
```

Run `carthage` to build the framework and drag the built `SwiftyWalkthrough.framework` into your Xcode project.

##Usage

SwiftyWalkthrough works by adding an overlay on top of your screen, blocking the access to your views. You can then control which views should be made accessible and when.

###Initialize a walkthrough or attach to an existing one

```swift
import SwiftyWalkthrough

if let _ = walkthroughView {
	// Attached to existing walkthrough
} else {
   let myCustomWalkthrough = CustomWalkthroughView()
   startWalkthrough(myCustomWalkthrough)
   // Walkthrough initialized
}
```

###Check if there is an ongoing walkthrough

Sometimes it is useful to know if there is an ongoing walkthrough (i.e. to adjust the logic on the view controllers). In that situation you can make use of the property ```ongoingWalkthrough```.

```swift
@IBAction func switchValueChanged(sender: UISwitch) {
    customWalkthroughView?.removeAllHoles()
    customWalkthroughView?.helpLabel.hidden = true
	
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "settingsWalkthroughComplete")
	
    if ongoingWalkthrough {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
```

###Cut holes on the overlay for the views you want to expose

```swift
@IBOutlet weak var nameField: UITextField!
@IBOutlet weak var surnameField: UITextField!
@IBOutlet weak var addressField: UITextField!

override func viewDidAppear(animated: Bool) {
	super.viewDidAppear(animated)
	walkthroughView?.cutHolesForViews([nameField]) // start by only allowing the interaction with nameField
}
```

`cutHolesForViews` will only look into your views' frames to cut the holes in the overlay. If you want to add some extra padding or define a corner radius, use `cutHolesForViewDescriptors` like this:

```swift
let descriptors = [
	ViewDescriptor(view: showProfileButton, extraPaddingX: 20, extraPaddingY: 10, cornerRadius: 10)
]

walkthroughView?.cutHolesForViewDescriptors(descriptors)
```

###Remove the holes

```swift
walkthroughView?.removeAllHoles()
```

###Close the walkthrough when it is finished

```swift
finishWalkthrough()
```

###Customization

By default, SwiftyWalkthrough only provides the mechanism to block the access to your views and cut holes to access them, it's up to you to customize it to suit your needs. You can do it by subclassing ```WalkthroughView``` and start the walkthrough with your custom walkthrough view. You can find more about this on the example provided with the library.

```swift
import UIKit
import SwiftyWalkthrough

class CustomWalkthroughView: WalkthroughView {
    // customize it
}

let myCustomWalkthrough = CustomWalkthroughView()
startWalkthrough(myCustomWalkthrough)
```

To specify the overlay's dim color at any time you just need to set the property `dimColor`:

```swift
walkthroughView?.dimColor = UIColor.redColor().colorWithAlphaComponent(0.7).CGColor
```

###WalkthroughViewDelegate

If for some reason you need to be notified right before the interaction with an exposed view, you can provide an implementation for the `willInteractWithView` method:

```swift
// MARK: - WalkthroughViewDelegate
    
func willInteractWithView(view: UIView) {
    print("Will interact with view \(view)")
}
```

**Note:** Keep in mind that `willInteractWithView` may be invoked multiple times, depending on the view hierarchy, as it relies on UIView's `hitTest` method. From the [UIView Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/index.html#//apple_ref/occ/instm/UIView/hitTest:withEvent:):

> This method traverses the view hierarchy by calling the pointInside:withEvent: method of each subview to determine which subview should receive a touch event. If pointInside:withEvent: returns true, then the subview’s hierarchy is similarly traversed until the frontmost view containing the specified point is found. If a view does not contain the point, its branch of the view hierarchy is ignored. You rarely need to call this method yourself, but you might override it to hide touch events from subviews.

> This method ignores view objects that are hidden, that have disabled user interactions, or have an alpha level less than 0.01. This method does not take the view’s content into account when determining a hit. Thus, a view can still be returned even if the specified point is in a transparent portion of that view’s content.

> Points that lie outside the receiver’s bounds are never reported as hits, even if they actually lie within one of the receiver’s subviews. This can occur if the current view’s clipsToBounds property is set to false and the affected subview extends beyond the view’s bounds.

## Using SwiftyWalkthrough in your app?

Let me know about it and I'll mention it here!

## Credits

Owned and maintained by Rui Costa ([@ruipfcosta](https://twitter.com/ruipfcosta)). 

Thanks to Andrew Jackman ([@andrew_jackman](https://twitter.com/andrew_jackman)).

## Contributing

Bug reports and pull requests are welcome.

## License

SwiftyWalkthrough is released under the MIT license. See LICENSE for details.
