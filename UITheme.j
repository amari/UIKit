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

@import <Foundation/CPObject.j>
@import <Foundation/CPBundle.j>

UIDefaultTheme = nil;

@implementation UITheme : CPObject {
	CPDictionary	_layerClasses @accessors(property=layerClasses); //Should be read-only
	CPBundle		_themeBundle;
	id				_delegate @accessors(property=delegate);
}

+ (UITheme)defaultTheme {
	if (!UIDefaultTheme)
		UIDefaultTheme = [UIApplication defaultTheme];
	return UIDefaultTheme;
}

+ (UITheme)themeWithURL:(CPURL)aURL {
	var _bundle = 	[CPBundle bundleWithURL:aURL];
					[_bundle load];
	if ([[_bundle principalClass] isKindOfClass:[UITheme class]])
		return [[[_bundle principalClass] alloc] initWithURL:aURL];
}

+ (UITheme)themeWithPath:(CPString)aPath {
	return [[UITheme alloc] initWithURL:aPath];
}

- (id)initWithURL:(CPURL)aURL {
	if (self = [super init]) {
		_layerClasses = {};
		
		_themeBundle = [CPBundle bundleWithURL:aURL];
		[_themeBundle setDelegate:self];
		[_themeBundle loadWithDelegate:self];
	}
	return self;
}

- (Class)layerClass:(Class)aLayerClass {
	var oldClassName = CPStringFromClass(aLayerClass);
	var newClassName = _layerClasses[oldClass];
	
	if (!newClassName)
		return aLayerClass;
	
	return CPClassFromString(newClassName);
}

- (void)bundleDidFinishLoading:(CPBundle)aBundle {
	[_delegate themeDidFinishLoading:self];
}

- (void)loadWithDelegate:(id)anObject {
	[self setDelegate:anObject];
	[_themeBundle loadWithDelegate:self];
}

@end