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

@import <Foundation/CPObject.j>

// This is the root of the responder tree.
var UIRootResponder = nil;

@implementation UIResponder : CPResponder { // Unsure whether it should be its own class, directly derived from CPObject
	UIResponder	_nextResponder @accessors(getter=nextResponder; setter=setNextResponder:);
	BOOL	_isFirstResponder;
	
	UIView	_inputView @accessors(inputView);
	UIView	_inputAccessoryView @accessors(getter=inputAccessoryView);
	
	UIUndoManager	_undoManager @accessors(getter=undoManager);
	
	DOMElement _DOMElement;
	
}

- (id)init {
	if (self = [super init]) {
		// This property is typically used to replace the system-supplied keyboard that is presented for UITextField and UITextView objects.
		_inputView = nil;
		//This property is typically used to attach an accessory view to the system-supplied keyboard that is presented for UITextField and UITextView objects.
		_inputAccessoryView = nil;
		
		_DOMElement = document;
		// WebKit Touch Events (http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html%23//apple_ref/doc/uid/TP40006511-SW1)
		_DOMElement.addEventListener('touchstart', function(evt) { [_view touchstartDOMEvent:evt]; }, false);
		_DOMElement.addEventListener('touchmove', function(evt) { [_view touchmoveDOMEvent:evt]; }, false);
		_DOMElement.addEventListener('touchend', function(evt) { [_view touchendDOMEvent:evt]; }, false);
		_DOMElement.addEventListener('touchend', function(evt) { [_view touchcancelDOMEvent:evt]; }, false);

		//_DOMElement.addEventListener('gesturestart', function(evt) { [_view gesturestartDOMEvent:evt]; }, false);
		//_DOMElement.addEventListener('gesturechange', function(evt) { [_view gesturechangeDOMEvent:evt]; }, false);
		//_DOMElement.addEventListener('gestureend', function(evt) { [_view gestureendDOMEvent:evt]; }, false);// WebKit Gesture Events (http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html%23//apple_ref/doc/uid/TP40006511-SW23)
		//document.addEventListener('gesturestart', function(evt) { [UIRootResponder _UIEventWithWebKitJSEvent:evt]; }, false);
		//document.addEventListener('gesturechange', function(evt) { [UIRootResponder _UIEventWithWebKitJSEvent:evt]; }, false);
		//document.addEventListener('gestureend', function(evt) { [UIRootResponder _UIEventWithWebKitJSEvent:evt]; }, false);
		// Mozilla Touch Events (https://developer.mozilla.org/en/DOM/Touch_events)
		//document.addEventListener('MozTouchDown', function(evt) { [UIRootResponder _UIEventWithMozillaJSEvent:evt]; });
		//document.addEventListener('MozTouchMove', function(evt) { [UIRootResponder _UIEventWithMozillaJSEvent:evt]; });
		//document.addEventListener('MozTouchUp', function(evt) { [UIRootResponder _UIEventWithMozillaJSEvent:evt]; });
	}
	return self;
}

- (void)touchstartDOMEvent:(JSObject)evt {
	evt.preventDefault();
	
	var touches = evt.changedTouches.map(function (x) { return [UITouch touchWithJSTouch:x]; });
		[self touchesBegan:[CPSet setWithArray:touches] withEvent:[UIEvent eventWithJSEvent:evt]];
}

- (void)touchmoveDOMEvent:(JSObject)evt {
	evt.preventDefault();
	
	var touches = evt.changedTouches.map(function (x) { return [UITouch touchWithJSTouch:x]; });
		[self touchesEnded:[CPSet setWithArray:touches] withEvent:[UIEvent eventWithJSEvent:evt]];
}

- (void)touchendDOMEvent:(JSObject)evt {
	evt.preventDefault();
	
	var touches = evt.changedTouches.map(function (x) { return [UITouch touchWithJSTouch:x]; });
		[self touchesMoved:[CPSet setWithArray:touches] withEvent:[UIEvent eventWithJSEvent:evt]];
}

- (void)touchcancelDOMEvent:(JSObject)evt {
	evt.preventDefault();
	
	var touches = evt.changedTouches.map(function (x) { return [UITouch touchWithJSTouch:x]; });
		[self touchesCanceled:[CPSet setWithArray:touches] withEvent:[UIEvent eventWithJSEvent:evt]];
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

- (void)touchesBegan:(CPSet)touches withEvent:(UIEvent)event {
	
}

- (void)touchesMoved:(CPSet)touches withEvent:(UIEvent)event {
	
}

- (void)touchesEnded:(CPSet)touches withEvent:(UIEvent)event {
	
}

- (void)touchesCancelled:(CPSet)touches withEvent:(UIEvent)event {
	
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
	if (!_nextResponder)
		return NO;
	return [_nextResponder canPerformAction:action withSender:sender];
}

@end