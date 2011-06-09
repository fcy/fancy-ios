Fancy iOS - Code Library
========================

Objective
---------
This project aims to be a useful library of reusable code for iOS developers.

To find out what is available you can run the project on Xcode or read the source code files specially the ones containing "Sample" on its name.

How to Use It
------------

The project ain't a static library or a framework that you add to your projects. Instead it's made by small independent (as much as possible) parts that you copy to your project and start using it.

The list of dependencies is listed as comments in the header files. 


- Xcode: 4.0
- Minumum iOS version: 4.0
- See the Xcode project to see the list of frameworks used. As of this moment there's no external frameworks or libraries in the project.


Current List of Components
==========================

UI
--

### FCRangeSlider (UIControl)

A variation of UISlider specialized to select a range of values. In other words it's a slider with two thumbs/trackers, the values between them are the range selected.

General Utilities
-----------------

### FCGeometry.h

A collection of simple C functions to make the code less verbose when dealing with CGGeometry structures.