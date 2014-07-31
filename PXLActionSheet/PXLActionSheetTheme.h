//
//  PXLActionSheetTheme.h
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

@property (nonatomic, assign) CGFloat animationSpeed;
@property (nonatomic, assign) CGFloat animationSpringDamping;
@property (nonatomic, assign) CGFloat animationSpringVelocity;

@property (nonatomic) UIColor *borderColor;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIColor *backdropShadowColor;

+ (instancetype)defaultTheme;

@end
