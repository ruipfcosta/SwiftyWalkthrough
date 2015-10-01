#SwiftyWalkthrough

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftyWalkthrough.svg)]()

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

See a live demo on [Appetize.io](https://appetize.io/embed/x9m9kxtq0eq6hgr7x4r91t0bgm?device=iphone6plus&scale=50&autoplay=false&orientation=portrait&deviceColor=black)

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

##Usage

SwiftyWalkthrough works by adding an overlay on top of your screen, blocking the access to your views. You can then control which views should be made accessible and when.

###Initialize a walkthrough or attach to an existing one

```swift
import SwiftyWalkthrough

if let _ = walkthroughView {
	// Attached to existing walkthrough
} else {
   initWalkthrough()
   // Walkthrough initialized
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

By default, SwiftyWalkthrough only provides the mechanism to block the access to your views and cut holes to access them, it's up to you to customize it to suit your needs. The best way to do so is by adding one or more subviews (i.e. images, label with instructions, etc) to `walkthroughView`. You can find more about this on the example provided with the library.

```swift
func customizeWalkthroughView() {
    if let wt = walkthroughView {
        wt.addSubview(customizedSubview)
        
        let views = ["customizedSubview": customizedSubview]
        wt.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[customizedSubview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        wt.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[customizedSubview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
}
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
