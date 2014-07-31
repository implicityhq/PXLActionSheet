//
//  PXLActionSheetTheme.m
//  PXLActionSheet
//
// Copyright (c) 2014 Jason Silberman
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "PXLActionSheetTheme.h"

@implementation PXLActionSheetTheme

+ (instancetype)defaultTheme {
	PXLActionSheetTheme *theme = [PXLActionSheetTheme new];
	
	theme.actionSheetStyle = PXLActionSheetStyleRounded;
	
	theme.titleFont = [UIFont fontWithName:@"Avenir" size:16];
	theme.buttonFont = [UIFont fontWithName:@"Avenir" size:18];
	
	theme.titleTextColor = [UIColor blackColor];
	theme.normalButtonTextColor = [UIColor blackColor];
	theme.destructiveButtonTextColor = [UIColor redColor];
	
	theme.normalButtonHighlightTextColor = [UIColor whiteColor];
	theme.destructiveButtonHighlightTextColor = [UIColor whiteColor];
	
	theme.normalButtonColor = [UIColor whiteColor];
	theme.destructiveButtonColor = [UIColor whiteColor];
	
	theme.normalButtonHighlightColor = [UIColor blackColor];
	theme.destructiveButtonHighlightColor = [UIColor redColor];
	
	theme.cornerRadius = 2.0;
	
	theme.animationSpeed = 0.55;
	theme.animationSpringDamping = 0.5;
	theme.animationSpringVelocity = 0.3;
	
	theme.borderColor = [UIColor colorWithWhite:0.0 alpha:0.25];
	theme.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
	theme.backdropShadowColor = [UIColor blackColor];
	
	return theme;
}

@end
