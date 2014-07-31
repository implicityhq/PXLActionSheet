//
//  PXLActionSheetTheme.h
//  Example
//
//  Created by Jason Silberman on 7/30/14.
//  Copyright (c) 2014 Jason Silberman. All rights reserved.
//

typedef NS_ENUM(NSInteger, PXLActionSheetStyle) {
	PXLActionSheetStyleSquared,
	PXLActionSheetStyleRounded
};

@interface PXLActionSheetTheme : NSObject

@property (nonatomic, assign) PXLActionSheetStyle actionSheetStyle;

@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIFont *buttonFont;

@property (nonatomic) UIColor *titleTextColor;
@property (nonatomic) UIColor *normalButtonTextColor;
@property (nonatomic) UIColor *destructiveButtonTextColor;

@property (nonatomic) UIColor *normalButtonHighlightTextColor;
@property (nonatomic) UIColor *destructiveButtonHighlightTextColor;

@property (nonatomic) UIColor *normalButtonColor;
@property (nonatomic) UIColor *destructiveButtonColor;

@property (nonatomic) UIColor *normalButtonHighlightColor;
@property (nonatomic) UIColor *destructiveButtonHighlightColor;

@property (nonatomic, assign) CGFloat cornerRadius; // Only with actionSheetStyleRounded

@property (nonatomic) UIColor *borderColor;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIColor *backdropShadowColor;

+ (instancetype)defaultTheme;

@end
