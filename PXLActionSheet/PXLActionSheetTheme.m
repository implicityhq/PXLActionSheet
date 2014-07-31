//
//  PXLActionSheetTheme.m
//  Example
//
//  Created by Jason Silberman on 7/30/14.
//  Copyright (c) 2014 Jason Silberman. All rights reserved.
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
	
	theme.borderColor = [UIColor colorWithWhite:0.0 alpha:0.25];
	theme.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
	theme.backdropShadowColor = [UIColor blackColor];
	
	return theme;
}

@end
