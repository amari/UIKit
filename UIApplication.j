/*
 * UIApplication.j
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
@import <Foundation/CPRunLoop.j>
@import "UIDevice.j"
@import "UIResponder.j"
@import "UITheme.j"

UIApp = nil,
CPApp = nil;

UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait;
UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown;
UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight;
UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft;

UIStatusBarStyleDefault = 0;
UIStatusBarStyleBlackTranslucent = 1;
UIStatusBarStyleBlackOpaque = 2;

UIStatusBarAnimationNone = 0;
UIStatusBarAnimationFade = 1;
UIStatusBarAnimationSlide = 2;

@implementation UIApplication : UIResponder
	CPNotificationCenter	_localNotificationCenter;
	
	CPArray		_eventListeners;
	UIEvent		_currentEvent;
	
	CPObject	_delegate 	@accessors(getter=delegate; setter=setDelegate:);
	UIWindow	_keyWindow 	@accessors(getter=keyWindow);
	CPArray		_windows	@accessors(getter=windows);
	UIWindow	_platformWindow @accessors(property=platformWindow);
	
	CPRunLoop	_drawingRunLoop;
	
	UITheme 	_defaultTheme @accessors(property=defaultTheme);
}

+ (UIApplication)sharedApplication {
	if (!UIApp) {
        UIApp = [[UIApplication alloc] init];
		CPApp = UIApp;
	}
    return UIApp;
}

- (id)init {
	if (self = [super init]) {
		_eventListeners = [];
		
		_windows = [];
		
		[_windows addObject:nil];
		
		[self bootstrap];
	}
	
	return self;
}

- (void)bootstrap {
	/* Create UIPlatformWindow. */
	_platformWindow = [[UIWindow alloc] initWithFrame:CGRectMakeZero()];
	[_platformWindow setLayer:[UIPlatformWindowLayer layer]];
	/* Load Default Theme. */
	var themeName = ([[CPBundle mainBundle] objectForInfoDictionaryKey:@"CPDefaultTheme"] || @"Aristo");
		themePath = [CPBundle pathForResource:themeName];
	_defaultTheme = [UITheme themeWithPath:themePath];
	[_defaultTheme loadWithDelegate:self];
}

- (void)finishLaunching {
	
}

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void(^)(void))handler { // handler should be a function()
	
}

- (void)beginIgnoringInteractionEvents {
	
}

- (void)beginReceivingRemoteControlEvents {
	
}

- (void)cancelAllLocalNotifications {
	
}

- (void)cancelLocalNotification:(UILocalNotification)notification {
	
}

- (BOOL)canOpenURL:(CPURL)url {
	
}

- (void)clearKeepAliveTimeout {
	
}

- (UIRemoteNotificationType)enabledRemoteNotificationTypes {
	
}

- (void)endBackgroundTask:(UIBackgroundTaskIdentifier)identifier {
	
}

- (void)endIgnoringInteractionEvents {
	
}

- (void)endReceivingRemoteControlEvents {
	
}

- (BOOL)isIgnoringInteractionEvents {
	
}

- (BOOL)openURL:(CPURL)url {
	
}

- (void)presentLocalNotificationNow:(UILocalNotification)notification {
	
}

- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types {
	
}

- (void)scheduleLocalNotification:(UILocalNotification)notification {
	
}

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent)anEvent {
	// Not sure how to implement this!
	return NO;
}

- (void)sendEvent:(UIEvent)anEvent {
	if (_keyWindow)
		[_keyWindow sendEvent:anEvent];
}

- (BOOL)setKeepAliveTimeout:(NSTimeInterval)timeout handler:(void(^)(void))keepAliveHandler {
	
}

- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation {
	// Unused
}

- (void)setStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation animated:(BOOL)animated {
	 // Unused
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated {
	// Unused
}

- (void)unregisterForRemoteNotifications {
	
}

@end

var UIApplicationMain(args, namedArgs) {
	// hook to allow recorder, etc to manipulate things before starting AppKit
	if (window.parent !== window && typeof window.parent._childAppIsStarting === "function")
		window.parent._childAppIsStarting(window);

	    var mainBundle = [CPBundle mainBundle],
	        principalClass = [mainBundle principalClass];

	    if (!principalClass)
	        principalClass = [UIApplication class];

	    [principalClass sharedApplication];

	    if ([args containsObject:"debug"])
	        CPLogRegister(CPLogPopup);

	    UIApp._args = args;
	    UIApp._namedArgs = namedArgs;

	    [UIApp bootstrap];
}