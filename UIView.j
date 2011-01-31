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

@import "UIResponder.j"
@import "UIColor.j"
@import "UIGestureRecognizer.j"
@import "UIViewLayer.j"

/* UIViewAnimationOptions */
var	UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
   	UIViewAnimationOptionAllowUserInteraction      = 1 <<  1,
   	UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2,
   	UIViewAnimationOptionRepeat                    = 1 <<  3,
   	UIViewAnimationOptionAutoreverse               = 1 <<  4,
   	UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5,
   	UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6,
   	UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7,
   	UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8,
   	UIViewAnimationOptionCurveEaseInOut            = 0 << 16,
   	UIViewAnimationOptionCurveEaseIn               = 1 << 16,
   	UIViewAnimationOptionCurveEaseOut              = 2 << 16,
   	UIViewAnimationOptionCurveLinear               = 3 << 16,
   	UIViewAnimationOptionTransitionNone            = 0 << 20,
   	UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
   	UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
   	UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
   	UIViewAnimationOptionTransitionCurlDown        = 4 << 20;

/* UIViewContentMode */
var UIViewContentModeScaleToFill,
   	UIViewContentModeScaleAspectFit,
   	UIViewContentModeScaleAspectFill,
   	UIViewContentModeRedraw,
   	UIViewContentModeCenter,
   	UIViewContentModeTop,
   	UIViewContentModeBottom,
   	UIViewContentModeLeft,
   	UIViewContentModeRight,
   	UIViewContentModeTopLeft,
   	UIViewContentModeTopRight,
   	UIViewContentModeBottomLeft,
   	UIViewContentModeBottomRight;

/* UIViewAutoresizing */
var UIViewAutoresizingNone                 = 0,
   	UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
   	UIViewAutoresizingFlexibleWidth        = 1 << 1,
   	UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
   	UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
   	UIViewAutoresizingFlexibleHeight       = 1 << 4,
   	UIViewAutoresizingFlexibleBottomMargin = 1 << 5;

/* UIViewAnimationTransition */
var UIViewAnimationTransitionNone,
   	UIViewAnimationTransitionFlipFromLeft,
   	UIViewAnimationTransitionFlipFromRight,
   	UIViewAnimationTransitionCurlUp,
   	UIViewAnimationTransitionCurlDown;

@implementation UIView : UIResponder {
	/* Configuring a View’s Visual Appearance */
	UIColor	_backgroundColor @accessors(property=ackgroundColor:);
	BOOL 	_hidden	@accessors(getter=isHidden;setter=setHidden:);
	CGFloat	_alpha	@accessors(property=alpha);
	BOOL	_opaque	@accessors(property=opaque);
	BOOL	_clipsToBounds @accessors(property=clipsToBounds);
	UIViewContentMode	_contentMode @accessors(propertyContentMode);
	BOOL _clearsContextBeforeDrawing	@accessors(property=clearsContextBeforeDrawing)
	CALayer	_layer	@accessors(getter=layer;setter=_setLayer:);
	/* Configuring the Event-Related Behavior*/
	BOOL _userInteractionEnabled	@accessors(getter=isUserInteractionEnabled;setter=setUserInteractionEnabled:);
	BOOL _multipleTouchEnabled	@accessors(getter=isMultipleTouchEnabled;setter=setMultipleTouchEnabled:);
	BOOL _exclusiveTouch	@accessors(getter=isExclusiveTouch;setter=setExclusiveTouch:);
	/* Configuring the Bounds and Frame Rectangles */
	CGRect _frame	@accessors(property=frame);
	CGRect _bounds	@accessors(property=bounds);
	CGPoint	_center @accessors(property=center);
	CGAffineTransform _transform @accessors(property=transform);
	/* Configuring the Resizing Behavior */
	UIViewAutoresizing _autoresizingMask @accessors(property=autoresizingMask);
	BOOL _autoresizesSubviews @accessors(property=autoresizesSubviews);
	UIViewContentMode _contentMode @accessors(property=contentMode);
	CGRect _contentStretch @accessors(property=contentStretch);
	/* Managing the View Hierarchy */
	UIView	_superview @accessors(getter=superview,setter=_setSuperview:);
	CPArray	_subviews @accessors(getter=subviews,setter=_setSubviews:);
	UIWindow _window @accessors(getter=window,setter=_setWindow:);
	/* Drawing and Updating the View */
	CGFloat _contentScaleFactor @accessors(property=contentScaleFactor);
	/* Managing Gesture Recognizers */
	CPArray _gestureRecognizers	@accessors(property=gestureRecognizers);
	/* Identifying the View at Runtime */
	CPInteger _tag @accesors(property=tag);
}

- (id)initWithFrame:(CGRect)aRect {
	/* Initializes and returns a newly allocated view
		object with the specified frame rectangle. */
	if (self = [super init]) {
		_backgroundColor = nil;
		_clearsContextBeforeDrawing = YES;
		_opaque = NO;
		_layer = [[self layerClass] layer];
		
		_userInteractionEnabled = YES;
		
		_transform = CGAffineTransformIdentity;
		
		_autoresizesSubviews = YES;
		
		_superview = nil;
		_subviews = [CPArray array];
		_window = nil;
		
		_gestureRecognizers = [CPArray array];
		
		_layer = [[UIViewLayer alloc] init];
		[_layer setView:self];
	}
	return self;
}

/* Configuring a View’s Visual Appearance */
+ (Class)layerClass {
	return [_layer class];
}

/* Configuring the Bounds and Frame Rectangles */
- (void)setBounds:(CGRect)aRect {
	_frame.size = aRect.size;
	_bounds = aRect;
}

- (void)setCenter:(CGPoint)aPoint {
	_frame.origin.x = aPoint.x - _frame.size.width/2;
	_frame.origin.y = aPoint.y - _frame.size.height/2;
	_center = aPoint;
}

/* Configuring the Resizing Behavior */
- (CGSize)sizeThatFits:(CGSize)size {
	
}

- (void)sizeToFit {
	
}

/* Managing the View Hierarchy */
- (void)addSubview:(UIView)view {
	[view setNextResponder:self];
	[view _setSuperview:self];
	[view _setWindow:_window];
	[_subviews addObject:view];
	[self setNeedsDisplay];
}

- (void)bringSubviewToFront:(UIView)view {
}

- (void)sendSubviewToBack:(UIView)view {
}

- (void)removeFromSuperview {
	[[_superview subviews] removeObject:self];
	[_superview setNeedsDisplay];
	_superview = nil;
	_window = nil;
	
	[self setNextResponder:nil];
}

- (void)insertSubview:(UIView)view atIndex:(NSInteger)index {
	[view setNextResponder:self];
	[view _setSuperview:self];
	[view _setWindow:_window];
	[_subviews insertObject:view atIndex:index];
	[self setNeedsDisplay];
}

- (void)insertSubview:(UIView)view aboveSubview:(UIView)siblingSubview {
	[_layer setZPosition:([[siblingSubview layer] ZPosition] + 1)];
	[_superview addSubview:view];
}

- (void)insertSubview:(UIView)view belowSubview:(UIView)siblingSubview {
	[_layer setZPosition:([[siblingSubview layer] ZPosition] - 1)];
	[_superview addSubview:view];
}

- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2 {
	var _view1 = [_subviews objectAtIndex:index1];
	var _view2 = [_subviews objectAtIndex:index2];
	[_subviews removeObjectAtIndex:index1];
	[_subviews insertObject:_view2 atIndex:index1];
	[_subviews removeObjectAtIndex:index2];
	[_subviews insertObject:_view1 atIndex:index2];
}

- (BOOL)isDescendantOfView:(UIView)view {
	if (view != self) {
		var _s = [view subviews];
		for (var s = 0, ss = [[view subviews] count]; s < ss; s++) {
			if ([self isDescendantOfView:_s[s]] == YES)
				return YES;
		} 
		return NO;
	}
	return YES;
}

/* Laying out Subviews */

- (void)layoutSubviews {
	
}

- (void)setNeedsLayout {
	
}

- (void)layoutIfNeeded {
	
}

/* Drawing and Updating the View */

- (void)drawRect:(CGRect)rect {
	// Draws into CALayer!!
}

- (void)setNeedsDisplay {
	
}

- (void)setNeedsDisplayInRect:(CGRect)invalidRect {
	
}

/* Managing Gesture Recognizers */

- (void)addGestureRecognizer:(UIGestureRecognizer)gestureRecognizer {
	[gestureRecognizer _setView:self];
	[_gestureRecognizers addObject:gestureRecognizer];
}

- (void)removeGestureRecognizer:(UIGestureRecognizer)gestureRecognizer {
	[_gestureRecognizers removeObject:gestureRecognizer];
	[gestureRecognizer release];
}

/* Animating Views with Blocks */

+ (void)animateWithDuration:(CPTimeInterval)duration delay:(CPTimeInterval)delay options:(UIViewAnimationOptions)options animations:(JSObject)animations completion:(JSObject)completion {
	/* 	This method initiates a set of animations to perform on the view.
		The block object in the animations parameter contains the code for
		animating the properties of one or more views. */
	// But since blocks don't exist in Objective-J, these are functions!!
}

+ (void)animateWithDuration:(CPTimeInterval)duration animations:(JSObject)animations completion:(JSObject)completion {
	/*	This method performs the specified animations immediately using the UIViewAnimationOptionCurveEaseInOut and UIViewAnimationOptionTransitionNone animation options.
		For example, if you want to fade a view until it is totally transparent and then remove it from your view hierarchy, you could use code similar to the following:

		[UIView animateWithDuration:0.2
		     animations: function(void) {view.alpha = 0.0;}
		     completion: function(finished){ [view removeFromSuperview]; }];
	*/
}

+ (void)animateWithDuration:(CPTimeInterval)duration animations:(JSObject)animations {
	/* 	This method performs the specified animations immediately using the
		UIViewAnimationOptionCurveEaseInOut and UIViewAnimationOptionTransitionNone
		animation options. */
}

+ (void)transitionWithView:(UIView)view duration:(CPTimeInterval)duration options:(UIViewAnimationOptions)options animations:(JSObject)animations completion:(JSObject)completion {
	/* 	This method applies a transition to the specified view so that you can make state changes to it.
		The block you specify in the animations parameter contains whatever state changes you want to make.
		You can use this block to add, remove, show, or hide subviews of the specified view.
		If you want to incorporate other animatable changes, you must include the UIViewAnimationOptionAllowAnimatedContent
		key in the options parameter.

		The following code creates a flip transition for the specified container view. At the appropriate point in the transition, one subview is removed and another is added to the container view. This makes it look as if a new view was flipped into place with the new subview, but really it is just the same view animated back into place with a new configuration.

		[UIView transitionWithView:containerView
	           	duration:0.2
	           	options:UIViewAnimationOptionTransitionFlipFromLeft
	           	animations:function(void) { [fromView removeFromSuperview]; [containerView addSubview:toView]; }
	           	completion:NULL];*/
}

+ (void)transitionFromView:(UIView)fromView toView:(UIView)toView duration:(CPTimeInterval)duration options:(UIViewAnimationOptions)options completion:(JSObject)completion {
	/* 	This method provides a simple way to transition from the view in the fromView parameter to the view in the toView parameter.
		By default, the view in fromView is replaced in the view hierarchy by the view in toView. If both views are already part of
		your view hierarchy, you can include the UIViewAnimationOptionShowHideTransitionViews option in the options parameter to
		simply hide or show them.
		This method modifies the views in their view hierarchy only. It does not modify your application’s view controllers in any way.
		For example, if you use this method to change the root view displayed by a view controller, it is your responsibility to update
		the view controller appropriately to handle the change.
		The view transition starts immediately unless another animation is already in-flight, in which case it starts immediately after the current animation finishes.*/
}

/* Identifying the View at Runtime */

- (UIView)viewWithTag:(CPInteger)tag {
	if (_tag != tag) {
		for (var t = 0, tt = [_subviews count]; t < tt; t++) {
			if ([[_subviews objectAtIndex:t] viewWithTag:tag] != nil)
				return [[_subviews objectAtIndex:t] viewWithTag:tag];
		}
		return nil;
	}
	return self;
}

/* Converting Between View Coordinate Systems */

- (CGPoint)convertPoint:(CGPoint)point toView:(UIView)view {
	var base1 = CGPointMake(0,0),
		base2 = CGPointMake(0,0),
		location = CGPointMake(0,0);
	
	// Find base1
	for (var _v = self; [_v superview] != nil; _v = [_v superview]) {
		base1.x += [_v frame].origin.x;
		base1.y += [_v frame].origin.y;
	}
	
	// Find base2
	for (var _v = view; [_v superview] != nil; _v = [_v superview]) {
		base2.x += [_v frame].origin.x;
		base2.y += [_v frame].origin.y;
	}
	
	location.x = point.x + base2.x - base1.x;
	location.y = point.y + base2.y - base1.y;
	return location;
}

- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView)view {
	var base1 = CGPointMake(0,0),
		base2 = CGPointMake(0,0),
		location = CGPointMake(0,0);
	
	// Find base1
	for (var _v = self; [_v superview] != [_v window]; _v = [v superview]) {
		base1.x += [_v frame].origin.x;
		base1.y += [_v frame].origin.y;
	}
	
	// Find base2
	for (var _v = view; [_v superview] != [_v window]; _v = [_v superview]) {
		base2.x += [_v frame].origin.x;
		base2.y += [_v frame].origin.y;
	}
	
	location.x = point.x + base1.x - base2.x;
	location.y = point.y + base1.y - base2.y;
	return location;
}

- (CGRect)convertRect:(CGRect)rect toView:(UIView)view {
	var r = rect;
	r.origin = [self convertPoint:rect.origin toView:view];
	return r;
}

- (CGRect)convertRect:(CGRect)rect fromView:(UIView)view {
	var r = rect;
	r.origin = [self convertPoint:rect.origin fromView:view];
	return r;
}

/* Hit Testing in a View */

- (UIView)hitTest:(CGPoint)point withEvent:(UIEvent)event {
	if ([self pointInside:point withEvent:event] == NO) {
		for (var t = 0, tt = [_subviews count]; t < tt; t++) {
			var v = [_subviews objectAtIndex:t],
				p = [self convertPoint:point toView:v];
			if ([v hitTest:p withEvent:event] == YES)
				return v;
		}
		return nil;
	}
	return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent)event {
	if (_hidden || _alpha < 0.01 || _userInteractionEnabled == NO)
		return NO;
	
	if ((_frame.origin.x + _frame.size.width >= point.x) && (_frame.origin.y + _frame.size.height >= point.y))
		return YES;
		
	return NO;
}

/* Ending a View Editing Session */

- (BOOL)endEditing:(BOOL)force {
	/* 	This method looks at the current view and its subview hierarchy for the text field that is currently the first responder.
		If it finds one, it asks that text field to resign as first responder. If the force parameter is set to YES, the
		text field is never even asked; it is forced to resign. */
	return YES;
}

/* Observing View-Related Changes */
- (void)didAddSubview:(UIView)subview {
	/* 	The default implementation of this method does nothing. Subclasses can override it to perform additional actions
		when subviews are added.This method is called in response to adding a subview using any of the relevant view methods. */
}

- (void)willRemoveSubview:(UIView)subview {
	/* 	The default implementation of this method does nothing. Subclasses can override it to perform additional actions
		whenever subviews are removed. This method is called when the subview’s superview changes or when the subview is
		removed from the view hierarchy completely. */
}

- (void)willMoveToSuperview:(UIView)newSuperview {
	/* 	The default implementation of this method does nothing. Subclasses can override it to perform additional
		actions whenever the superview changes. */
}

- (void)didMoveToSuperview {
	/* 	The default implementation of this method does nothing. Subclasses can override it to perform additional
		actions whenever the superview changes. */
}

- (void)willMoveToWindow:(UIWindow)newWindow {
	/* The window object that will be at the root of the receiver's new view hierarchy. This parameter may be nil. */
}

- (void)didMoveToWindow {
	/* 	The default implementation of this method does nothing. Subclasses can override it to perform additional
		actions whenever the window changes. */
}

/* UIResponder */

- (void)touchesBegan:(CPSet)touches withEvent:(UIEvent)anEvent
{
	_gestureRecognizers.forEach(function (x) { [x touchesBegan:touches withEvent:anEvent] });
}

- (void)touchesEnded:(CPSet)touches withEvent:(UIEvent)anEvent
{
	_gestureRecognizers.forEach(function (x) { [x touchesEnded:touches withEvent:anEvent] });
}

- (void)touchesMoved:(CPSet)touches withEvent:(UIEvent)anEvent
{
	_gestureRecognizers.forEach(function (x) { [x touchesMoved:touches withEvent:anEvent] });
}

@end

@implementation UIView (CPCoding)

@end