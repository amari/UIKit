/*
 * UIEvent.j
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

/* http://developer.apple.com/library/ios/#documentation/uikit/reference/UIEvent_Class/Reference/Reference.html */

@import <Foundation/CPObject.j>
@import "UIGestureRecognizer.j"

/* UIEventType */
var	UIEventTypeTouches = 0,
	UIEventTypeMotion = 1,
	UIEventTypeRemoteControl = 2;
	
/* UIEventSubtype */
var	UIEventSubtypeNone                              = 0,
	UIEventSubtypeMotionShake                       = 1,
   	UIEventSubtypeRemoteControlPlay                 = 100,
   	UIEventSubtypeRemoteControlPause                = 101,
   	UIEventSubtypeRemoteControlStop                 = 102,
   	UIEventSubtypeRemoteControlTogglePlayPause      = 103,
   	UIEventSubtypeRemoteControlNextTrack            = 104,
   	UIEventSubtypeRemoteControlPreviousTrack        = 105,
   	UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
   	UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
   	UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
   	UIEventSubtypeRemoteControlEndSeekingForward    = 109;

@implementation UIEvent : CPObject {
	CPTimeInterval	_timestamp @accessors(getter=timestamp);
	UIEventType		_type	@accessors(getter=type);
	UIEventSubtype	_subtype	@accessors(getter=subtype);
	
	CPSet	_touches;
}

- (id)init {
	if (self = [super init]) {
		_touches = [CPSet set];
	}
	return self;
}

/* Getting the Touches for an Event */

+ (UIEvent)eventWithJSEvent:(id)anEvent {
	return [[UIEvent alloc] init];
}

- (CPSet)allTouches {
	return _touches;
}

- (CPSet)touchesForView:(UIView)view {
	var s = [CPSet set];
	for (var t in _touches) {
		if ([t view] == view)
			[s insertObject:[_touches objectAtIndex:t]];
	}
	return s;
}

- (CPSet)touchesForWindow:(UIWindow)_window {
	var s = [CPSet set];
	for (var t in _touches) {
		if ([t window] == _window)
			[s insertObject:[_touches objectAtIndex:t]];
	}
	return s;
}

/* Getting the Touches for a Gesture Recognizer */

- (CPSet)touchesForGestureRecognizer:(UIGestureRecognizer)gesture {
	var s = [CPSet set];
	for (var t in _touches) {
		if ([[t gestureRecognizers] hasObject:gesture])
			[s insertObject:[_touches objectAtIndex:t]];
	}
	return s;
}

@end
