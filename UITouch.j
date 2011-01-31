/*
 * UITouch.j
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

/* http://developer.apple.com/library/ios/#documentation/uikit/reference/UITouch_Class/Reference/Reference.html%23//apple_ref/occ/cl/UITouch */

@import <Foundation/CPObject.j>

/* UITouchPhase */
var	UITouchPhaseBegan = 0
   	UITouchPhaseMoved = 1,
   	UITouchPhaseStationary = 2,
   	UITouchPhaseEnded = 3,
   	UITouchPhaseCancelled = 4;

@implementation UITouch : CPObject {
	UIView		_view	@accessors(property=view);
	UIWindow	_window @accessors(property=window);
	
	int			_tapCount @accessors(getter=tapCount);
	CPTimeInterval	_timestamp @accessors(getter=timestamp);
	UITouchPhase	_phase @accessors(getter=phase);
	
	CPArray		_gestureRecognizers	@accessors(getter=gestureRecognizers);
	
	CGPoint	_location @accessors(property=location);
	CGPoint _previousLocation @property(property=previousLocation);
}

- (id)init {
	if (self = [super init]) {
		_view = nil;
		_window = nil;
		_tapCount = 0;
		_timestamp = 0;
		_phase = -1;
		_gestureRecognizers = [CPArray array];
	}
	return self;
}

+ (UITouch)touchWithJSTouch:(id)anEvent {
	var touch = [[UITouch alloc] init];
	var location = CGPointMake(anEvent.screenX,anEvent.screenY);
	var view = [[UIApp keyWindow] hitTest:location];
	var element = anEvent.target;
	
	[touch setPreviousLocation:[touch location]];
	[touch setLocation:location];
	[touch setView:view];
	[touch setWindow:[view window]];
	[touch setPhase:UITouchPhaseBegan];
	[touch setTimestamp:[CPDate date]];
	return touch;
}

/* Getting the Location of Touches */
// _location and _previousLocation are relative to a UIWindow,
// so we need to convert the coordinates.

- (CGPoint)locationInView:(UIView)view {
	return [_view convertPoint:_location fromView:[UIApp keyWindow]];
}

- (CGPoint)previousLocationInView:(UIView)view {
	return [_view convertPoint:_previousLocation fromView:[UIApp keyWindow]];
}

@end
