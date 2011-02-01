/*
 * UIWindow.j
 * UIKit
 *
 * Created by Amari Robinson.
 * Copyright 2011, Amari Robinson.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import <Foundation/CPObject.j>
@import "UIView.j"
@import "UIViewController.j"
@import "UIScreen.j"

/* UIWindowLevel */
var	UIWindowLevelNormal = 0.0,
	UIWindowLevelAlert = 0.5,
	UIWindowLevelStatusBar = 1.0;
	
/* Keyboard Notification User Info Keys */
var UIKeyboardFrameBeginUserInfoKey = @"UIKeyboardFrameBeginUserInfoKey",
	UIKeyboardFrameEndUserInfoKey = @"UIKeyboardFrameEndUserInfoKey",
	UIKeyboardAnimationDurationUserInfoKey = @"UIKeyboardAnimationDurationUserInfoKey",
	UIKeyboardAnimationCurveUserInfoKey = @"UIKeyboardAnimationCurveUserInfoKey";
	
/* Notifications */
var	UIWindowDidBecomeVisibleNotification = @"UIWindowDidBecomeVisibleNotification",
	UIWindowDidBecomeHiddenNotification = @"UIWindowDidBecomeHiddenNotification",
	UIWindowDidBecomeKeyNotification = @"UIWindowDidBecomeKeyNotification",
	UIWindowDidResignKeyNotification = @"UIWindowDidResignKeyNotification",
	UIKeyboardWillShowNotification = @"UIKeyboardWillShowNotification",
	UIKeyboardDidShowNotification = @"UIKeyboardDidShowNotification",
	UIKeyboardWillHideNotification = @"UIKeyboardWillHideNotification",
	UIKeyboardDidHideNotification = @"UIKeyboardDidHideNotification";

@implementation UIWindow : UIView {
	UIWindowLevel 	_windowLevel @accessors(getter=windowLevel;setter=setWindowLevel:);
	UIScreen	_screen	@accessors(getter=screen);
	UIViewController	_rootViewController @accessors(getter=rootViewController;setter=setRootViewController:);
	
	BOOL	_keyWindow	@accessors(getter=isKeyWindow);
}

- (id)initWithFrame:(CGRect)aRect {
	if (self = [super initWithFrame:aRect]) {
		_windowLevel = 0.0;
	}
	return self;
}

/* Making Windows Key */

- (void)makeKeyAndVisible {
	/*
		This is a convenience method to make the receiver the main window
		and displays it in front of other windows. You can also hide and
		reveal a window using the inherited hidden property of UIView. */
}

- (void)becomeKeyWindow {
	/*
		This method reestablishes the receiver’s first responder,
		sends the becomeKeyWindow message to that object if it responds,
		and posts UIWindowDidBecomeKeyNotification to the default notification center. */
}

- (void)makeKeyWindow {
	/* Makes the receiver the main window. */
}

- (void)resignKeyWindow {
	/* Invoked automatically when the window resigns key window status; never invoke this method directly. */
}

/* Converting Coordinates */

- (CGPoint)convertPoint:(CGPoint)point toWindow:(UIWindow *)window {
	/* Converts a point from the receiver’s coordinate system to that of another window. */
}

- (CGPoint)convertPoint:(CGPoint)point fromWindow:(UIWindow *)window {
	/* Converts a point from the coordinate system of a given window to that of the receiver. */
}

- (CGRect)convertRect:(CGRect)rect toWindow:(UIWindow *)window {
	/* Converts a rectangle from the receiver’s coordinate system to that of another window. */
}

- (CGRect)convertRect:(CGRect)rect fromWindow:(UIWindow *)window {
	/* Converts a rectangle from the coordinate system of another window to that of the receiver. */
}

/* Sending Events */

- (void)sendEvent:(UIEvent)event {
	/* Dispatches events sent to the receiver by the UIApplication object to its views. */
	[[event window] sendEvent:event];
}

@end