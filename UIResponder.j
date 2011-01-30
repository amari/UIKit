/*
 * UIResponder.j
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

@import <AppKit/CPResponder.j>

@implementation UIResponder : CPResponder { // Unsure whether it should be its own class, directly derived from CPObject
	UIResponder	_nextResponder @accessors(getter=nextResponder; setter=setNextResponder:);
	BOOL	_isFirstResponder;
	
	UIView	_inputView @accessors(inputView);
	UIView	_inputAccessoryView @accessors(getter=inputAccessoryView);
	
	UIUndoManager	_undoManager @accessors(getter=undoManager);
}

- (id)init {
	if (self = [super init]) {
		// This property is typically used to replace the system-supplied keyboard that is presented for UITextField and UITextView objects.
		_inputView = nil;
		//This property is typically used to attach an accessory view to the system-supplied keyboard that is presented for UITextField and UITextView objects.
		_inputAccessoryView = nil;
		
		// Setup Touch Events
		// WebKit Touch Events (http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html%23//apple_ref/doc/uid/TP40006511-SW1)
		document.addEventListener('touchstart', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		document.addEventListener('touchmove', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		document.addEventListener('touchend', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		document.addEventListener('touchcancel', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		// WebKit Gesture Events (http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html%23//apple_ref/doc/uid/TP40006511-SW23)
		document.addEventListener('gesturestart', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		document.addEventListener('gesturechange', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		document.addEventListener('gestureend', function(evt) { [self _UIEventWithWebKitJSEvent:evt]; }, false);
		// Mozilla Touch Events (https://developer.mozilla.org/en/DOM/Touch_events)
		document.addEventListener('MozTouchDown', function(evt) { [self _UIEventWithMozillaJSEvent:evt]; });
		document.addEventListener('MozTouchMove', function(evt) { [self _UIEventWithMozillaJSEvent:evt]; });
		document.addEventListener('MozTouchUp', function(evt) { [self _UIEventWithMozillaJSEvent:evt]; });
	}
	return self;
}

- (UIEvent)_UIEventWithWebKitJSEvent:(JSEvent)evt { // This should be a UIEvent method, but....
	evt.preventDefault(); // Just so that events don't propogate to the browser. (Unwanted Scrolling)

	// Each "touch" is a finger touching the screen.
	// Optionally, get all touches for the target element using the targetTouches property.
	var touches = evt.targetTouches;
	// Optionally, get all changed touches for this event using the changedTouches property:
	var changed = evt.changedTouches;
	//
	var numberOfFingers = evt.touches.length;
	if (evt.type == "touchstart") {
		
	}
	else if (evt.type == "touchend") {
		
	}
	else if (evt.type == "touchmove") {
		
	}
	else if (evt.type == "touchcancel") {
		
	}
	else if (evt.type == "gesturestart") {
		
	}
	else if (evt.type == "gesturechange") {
		
	}
	else if (evt.type == "gestureend") {
		
	}
	
	return nil;
}

- (UIEvent)_UIEventWithMozillaJSEvent:(JSEvent)evt { // This should be a UIEvent method, but....
	evt.preventDefault(); // Just so that events don't propogate to the browser. (Unwanted Scrolling)
	
	if (evt.type == "MozTouchDown") {
		
	}
	else if (evt.type == "MozTouchMove") {
		
	}
	else if (evt.type == "MozTouchUp") {
		
	}
	
	return nil;
}

- (BOOL)isFirstResponder {
	return NO;
}

- (BOOL)canBecomeFirstResponder {
	return NO;
}

- (BOOL)becomeFirstResponder {
	return YES;
}

- (BOOL)canResignFirstResponder {
	return YES;
}

- (BOOL)resignFirstResponder {
	return YES;
}

/* Managing Input Views */

- (void)reloadInputViews {
	
}

/* Responding to Touch Events */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

/* Responding to Motion Events */

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
}

/* */

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
	
}

/* Validating Commands */

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
	return NO;
}

@end