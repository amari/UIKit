# UIKit
A Objective-J implementation of Apple's UIKit Framework. Designed for Mobile App development with Objective-J and Cappuccino.

# Design Goals
Like UIKit is the replacement for AppKit on iOS devices, UIKit is aimed to be the equivalent for all touchscreen devices.

# Status
Alpha Stage
## What's Done
### UIDevice
Tracks changes in device orientation.
Differentiation between a tablet and a phone.
### UIApplication, UIEvent, UITouch
Skeleton.
## Currently Being Worked On
### UIResponder
Converting DOM GestureEvents and TouchEvents into UIEvents.
Handling Gyroscopic Motions, if its even possible. Documentation is needed!
### UIEvent
Implementation.
### UITouch
Implementation.
## Todo
### UIView
CALayer backing.

# Reference
[UIKit Documentation at Apple](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIKit_Framework/_index.html)
[Mozilla DOM Touch Events](https://developer.mozilla.org/en/DOM/Touch_events)
[WebKit DOM Touch Events](http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html%23//apple_ref/doc/uid/TP40006511-SW1)

# Contributors
Amari Robinson

# License
This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA