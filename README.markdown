Fancy iOS - Code Library
========================

Objective
---------
This project aims to be a useful library of reusable code for iOS developers.

How to Use It
------------

### CocoaPods
Add to your project's `Podfile`:

```
pod 'Fancy-iOS'
```

The pod is very modularized with subspecs and you can install only what you need. For example,
if you want only the `FCYRangeSlider` put this in your `Podfile`:

```
pod 'Fancy-iOS/UI/RangeSlider'
```

#### Available specs & subspecs

- Fancy-iOS
-- Core
-- UI
--- AutoLayout
--- Geometry
--- ImageAdditions
--- RangeSlider

Requirements
------------

- Minumum iOS version: 6.0
- ARC
- See the Xcode project to see the list of frameworks used. As of
this moment there's no external frameworks or libraries in the project.

- Or use CocoaPods and let it handle all of this.


More Information
==========================

For a list of available components and what Fancy iOS can do for you
see the project's documentation: [fcy.github.com/fancy-ios](http://fcy.github.com/fancy-ios)

A word of advice unfortunately [appledoc](http://gentlebytes.com/appledoc/) doesn't support C functions so check out
the source headers for functions and typdefs that aren't in the documentation. They are documented in the header files.