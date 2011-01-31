/*
 * UIView.j
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

@import "CoreAnimation/CALayer.j"

@implementation UIViewLayer : CALayer {
	UIView _view @accessors(property=view);
}

- (id)init {
	if (self = [super init]) {
		
	}
	
	return self;
}

- (void)setView:(UIView)aView {
	[super setView:aView];
	/*
	_DOMElement.addEventListener('touchstart', function(evt) { [_view touchstartDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('touchmove', function(evt) { [_view touchmoveDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('touchend', function(evt) { [_view touchendDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('touchend', function(evt) { [_view touchcancelDOMEvent:evt]; }, false);
	
	_DOMElement.addEventListener('gesturestart', function(evt) { [_view gesturestartDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('gesturechange', function(evt) { [_view gesturechangeDOMEvent:evt]; }, false);
	_DOMElement.addEventListener('gestureend', function(evt) { [_view gestureendDOMEvent:evt]; }, false);
	*/
}

@end