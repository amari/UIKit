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
	CPTimeInterval	_timestamp @accessors(property=timestamp);
	UIEventType		_type	@accessors(property=type);
	UIEventSubtype	_subtype	@accessors(property=subtype);
	
	CPSet	_touches	@accessors(property=allTouches);
	CPSet	_changedTouches @accessors(property=changedTouches);
}

- (id)init {
	if (self = [super init]) {
		_touches = [CPSet set];
		_changedTouches = [CPSet set];
	}
	return self;
}

+ (UIEvent)eventWithJSEvent:(id)anEvent {
	var e = [[UIEvent alloc] init];
	[e setType:UIEventTypeTouches];
	[e setSubtype:UIEventSubtypeNone];
	[e setChangedTouches:anEvent.changedTouches];
	[e setTouches:anEvent.allTouches];
	return e;
}

/* Getting the Touches for an Event */

- (CPSet)allTouches {
	return _touches;
}

- (CPSet)touchesForView:(UIView)view {
	//return [view allTouches];
	var s = [CPSet set];
	for (var t in _touches) {
		if ([_touches[t] view] == view)
			[s insertObject:[_touches objectAtIndex:t]];
	}
	return s;
}

- (CPSet)touchesForWindow:(UIWindow)_window {
	//return [_window allTouches];
	var s = [CPSet set];
	for (var t in _touches) {
		if ([_touches[t] window] == _window)
			[s insertObject:[_touches objectAtIndex:t]];
	}
	return s;
}

/* Getting the Touches for a Gesture Recognizer */

- (CPSet)touchesForGestureRecognizer:(UIGestureRecognizer)gesture {
	//return [gesture touches];
	var s = [CPSet set];
	for (var t in _touches) {
		if ([[_touches[t] gestureRecognizers] hasObject:gesture])
			[s insertObject:[_touches objectAtIndex:t]];
	}
	return s;
}

@end
