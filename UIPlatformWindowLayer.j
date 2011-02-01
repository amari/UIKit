/*
 * UIPlatformWindowLayer.j
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
@import "CoreAnimation/CPLayer.j"
@import "UITouch.j"
@import "UIEvent.j"

@implementation UIPlatformWindowLayer : CALayer
	DOMElement 	_DOMElement;
	UIWindow	_view @accessors(property=view);
	
	CPSet	_allTouches @accessors(property=allTouches); // There should be up to nine.
}

- (id)init { //Mimicking CPPlatformWindow here
	if(self = [super init]) {
		_DOMElement = window;
		_bounds = CGRectMakeZero();
		_frame = CGRectMakeZero();
		
		[self registerDOMWindow];
	}
}

- (void)registerDOMWindow {
	/* Setup the Event Handlers */
	// WebKit Touch Events (http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html%23//apple_ref/doc/uid/TP40006511-SW1)
	_DOMElement.addEventListener('touchstart', function(evt) { [self touchstartDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('touchmove', function(evt) { [self touchmoveDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('touchend', function(evt) { [self touchendDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('touchcancel', function(evt) { [self touchcancelDOMEvent:evt]; }, false);
	
	//_DOMElement.addEventListener('gesturestart', function(evt) { [self gesturestartDOMEvent:evt]; }, false);
	//_DOMElement.addEventListener('gesturechange', function(evt) { [self gesturechangeDOMEvent:evt]; }, false);
	//_DOMElement.addEventListener('gestureend', function(evt) { [self gestureendDOMEvent:evt]; }, false);
	
	// Mozilla Touch Events (https://developer.mozilla.org/en/DOM/Touch_events)
	//_DOMElement.addEventListener('MozTouchDown', function(evt) { [self MozTouchDownDOMEvent:evt]; });
	//_DOMElement.addEventListener('MozTouchMove', function(evt) { [self MozTouchMoveDOMEvent:evt]; });
	//_DOMElement.addEventListener('MozTouchUp', function(evt) { [self MozTouchUpDOMEvent:evt]; });
}

- (void)touchstartDOMEvent:(JSEvent)anEvent { /* Are we going to send the event to the view, or add it to a runloop? */
	anEvent.allTouches.forEach (function (x) { _alltouches[x.identifier] = [UITouch touchWithJSTouch:x]; });
	var e = [UIEvent eventWithJSEvent:anEvent];
	[e setAllTouches:_allTouches];
	[_view touchesBegan:_allTouches withEvent:e];
}

- (void)touchmoveDOMEvent:(JSEvent)anEvent { /* Are we going to send the event to the view, or add it to a runloop? */
	anEvent.allTouches.forEach (function (x) {
		[_alltouches[x.identifier] setPhase:UITouchPhaseStationary];
	});
	anEvent.changedTouches.forEach (function (x) {
		[_alltouches[x.identifier] setPhase:UITouchPhaseMoved];
		[_alltouches[x.identifier] setPreviousLocation:[_alltouches[x.identifier] location]];
		[_alltouches[x.identifier] setLocation:CGPointMake(anEvent.screenX, anEvent.screenY)];
	});
	var e = [UIEvent eventWithJSEvent:anEvent];
	[e setAllTouches:_allTouches];
	[_view touchesMoved:_allTouches withEvent:e];
}

- (void)touchendDOMEvent:(JSEvent)anEvent { /* Are we going to send the event to the view, or add it to a runloop? */
	anEvent.changedTouches.forEach (function (x) {
		[_alltouches[x.identifier] setPhase:UITouchPhaseEnded];
	});
	var e = [UIEvent eventWithJSEvent:anEvent];
	[e setAllTouches:_allTouches];
	[_view touchesEnded:_allTouches withEvent:e];
}

- (void)touchcancelDOMEvent:(JSEvent)anEvent { /* Are we going to send the event to the view, or add it to a runloop? */
	anEvent.changedTouches.forEach (function (x) {
		[_alltouches[x.identifier] setPhase:UITouchPhaseCanceled];
	});
	var e = [UIEvent eventWithJSEvent:anEvent];
	[e setAllTouches:_allTouches];
	[_view touchesCanceled:_allTouches withEvent:e];
}

@end