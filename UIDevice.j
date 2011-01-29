/*
 * UIDevice.j
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

UIDevice = nil;

// UIDeviceBatteryState - The battery power state of the device.
UIDeviceBatteryStateUnknown = @"UIDeviceBatteryStateUnknown";
UIDeviceBatteryStateUnplugged = @"UIDeviceBatteryStateUnplugged";
UIDeviceBatteryStateCharging = @"UIDeviceBatteryStateCharging";
UIDeviceBatteryStateFull = @"UIDeviceBatteryStateFull";

// UIDeviceOrientation - The physical orientation of the device.
UIDeviceOrientationUnknown = @"UIDeviceOrientationUnknown";
UIDeviceOrientationPortrait = @"UIDeviceOrientationPortrait";
UIDeviceOrientationPortraitUpsideDown = @"UIDeviceOrientationPortraitUpsideDown";
UIDeviceOrientationLandscapeLeft = @"UIDeviceOrientationLandscapeLeft";
UIDeviceOrientationLandscapeRight = @"UIDeviceOrientationLandscapeRight";
UIDeviceOrientationFaceUp = @"UIDeviceOrientationFaceUp";
UIDeviceOrientationFaceDown = = @"UIDeviceOrientationFaceDown";

// UIUserInterfaceIdiom – The type of interface that should be used on the current device.
UIUserInterfaceIdiomPhone = @"UIUserInterfaceIdiomPhone";
UIUserInterfaceIdiomPad = @"UIUserInterfaceIdiomPad";

// All UIDevice notifications are posted by the singleton device instance returned by currentDevice.
UIDeviceBatteryLevelDidChangeNotification = @"UIDeviceBatteryLevelDidChangeNotification";
UIDeviceBatteryStateDidChangeNotification = @"UIDeviceBatteryStateDidChangeNotification";
UIDeviceOrientationDidChangeNotification = @"UIDeviceOrientationDidChangeNotification";
UIDeviceProximityStateDidChangeNotification = @"UIDeviceProximityStateDidChangeNotification";

@implementation UIDevice : CPObject {
	BOOL 		_multitaskingSupported	@accessors(getter=multitaskingSupported);
	
	CPString	_uniqueIdentifier	@accessors(getter=uniqueIdentifier);
	CPString	_name	@accessors(getter=name);
	CPString	_systemName @accessors(getter=systemName);
	CPString	_systemVersion @accessors(getter=systemVersion);
	CPString	_model	@accessors(getter=model);
	CPString	_localizedModel @accessors(getter=localizedModel);
	UIUserInterfaceIdiom	_userInterfaceIdiom @accessors(getter=userInterfaceIdiom);
	
	UIDeviceOrientation	_orientation	@accessors(getter=orientation);
	BOOL		_generatesDeviceOrientationNotifications @accessors(getter=isGeneratingDeviceOrientationNotifications);
	
	float		_batteryLevel	@accessors(getter=batteryLevel);
	BOOL		_batteryMonitoringEnabled	@accessors(getter=isBatteryMonitoringEnabled);
	UIDeviceBatteryState	_batteryState	@accessors(getter=batteryState);
	
	BOOL		_proximityMonitoringEnabled	@accessors(getter=isProximityMonitoringEnabled);
	BOOL		_proximityState	@accessors(getter=proximityState);
}

+ (UIDevice)currentDevice {
	// Detect which device we are
	if (!UIDevice)
		UIDevice = [[UIDevice alloc] init];
	return UIDevice;
}

- (id)init {
	if (self = [super init]) {
		// Device Information.
		_name = @"Generic UIDevice";
		_systemName = navigator.platform;
		_systemVersion = navigator.appVersion;
		_model = @"Generic UIDevice";
		_localizedModel = _model;
		
		// Multitasking. Included in all UIDevices.
		_multitaskingSupported = YES;
		
		// Orientation.
		_orientation = UIDeviceOrientationUnknown;
		_generatesDeviceOrientationNotifications = NO;
		if (window.orientation) {
			window.addEventListener("deviceorientation", function (evt) {[[UIDevice currentDevice] _updateOrientationWithDOMWindowEvent];}, true);
			[[UIDevice currentDevice] _updateOrientationWithDOMWindowEvent];
			_generatesDeviceOrientationNotifications = YES;
		}
		
		// Tablet or Phone.
		var width = document.screen.width / document.screen.depth;
		var height = document.screen.height / document.screen.depth;
		var diagonal = Math.sqrt((width*width)+(height*height));
		
		if (diagonal > 5) // Let's assume that 5 inches is the maximum screen size that a sane person would design a phone.
			_userInterfaceIdiom = UIUserInterfaceIdiomPad;
		else
			_userInterfaceIdiom = UIUserInterfaceIdiomPhone;
		
		// Proximity Monitoring.
		_proximityMonitoringEnabled = NO;
		_proximityState = NO;
		
		// Battery monitoring.
		_batteryLevel = -1.0;
		_batteryMotitoringEnabled = NO;
		_batteryState = UIDeviceBatteryStateUnknown;
	}
	return self;
}

- (void)_updateOrientationWithDOMWindowEvent {
	switch (window.orientation) {
		case 0:
			_orientation = UIDeviceOrientationPortrait;
			break;
		case 90:
			_orientation = UIDeviceOrientationLandscapeLeft;
			break;
		case -90:
			_orientation = UIDeviceOrientationLandscapeRight;
			break;
		case 180:
			_orientation = UIDeviceOrientationPortraitUpsideDown;
			break;
		default:
			_orientation = UIDeviceOrientationUnknown;
			break;
	}
	[[[CPNotificationCenter] defaultCenter] postNotificationName:UIDeviceOrientationDidChangeNotification object:self userInfo:nil];
}

@end