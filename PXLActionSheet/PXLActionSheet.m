//
//  PXLActionSheet.m
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

#import "PXLActionSheet.h"
#import "PXLActionSheetTheme.h"

// Padding
static const CGFloat PXLActionSheetButtonVerticalPadding = 10.0;
static const CGFloat PXLActionSheetButtonHorizontalPadding = 10.0;
static const CGFloat PXLActionSheetTitlePadding = 10.0;

// Heights
static const CGFloat PXLActionSheetButtonHeight = 44.0;

NSString *NSStringFromActionSheetVisibility(PXLActionSheetVisibility visibility) {
	if (visibility == PXLActionSheetVisibilityHidden) {
		return @"PXLActionSheetVisibilityHidden";
	} else if (visibility == PXLActionSheetVisibilityVisible) {
		return @"PXLActionSheetVisibilityVisible";
	} else {
		return @"NaN";
	}
}

#pragma mark - UIButton+BackgroundColorForState Category

@interface UIButton (BackgroundColorForState)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

@implementation UIButton (BackgroundColorForState)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
	UIImage *img = nil;
	
	CGRect rect = CGRectMake(0, 0, 2, 2);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
	CGContextFillRect(context, rect);
	
	img = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	[self setBackgroundImage:img forState:state];
}

@end

#pragma mark - UIView+RoundCornersMask Category

@interface UIView (CornerRadiusWithCorners)

- (void)applyCornerRadiusMaskForCorners:(UIRectCorner)corners withRadius:(CGFloat)radius;

@end

@implementation UIView (CornerRadiusWithCorners)

- (void)applyCornerRadiusMaskForCorners:(UIRectCorner)corners withRadius:(CGFloat)radius {
	UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
	
	CAShapeLayer *shape = [[CAShapeLayer alloc] init];
	[shape setPath:rounded.CGPath];
	
	self.layer.mask = shape;
}

@end

@interface PXLActionSheet ()
@property (nonatomic, copy) PXLActionSheetTapBlock tapBlock;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *cancelButtonTitle;
@property (nonatomic) NSString *destructiveButtonTitle;
@property (nonatomic) NSArray *otherButtonTitles;
@property (nonatomic) UIView *containerView;

// UI
@property (nonatomic) UIView *actionSheetBackgroundView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *cancelButton;

@property (nonatomic) UIView *containerSnapShotView;

@property (nonatomic) PXLActionSheetTheme *theme;

@end

@implementation PXLActionSheet

#pragma mark - Init

+ (instancetype)showInView:(UIView *)view withTheme:(PXLActionSheetTheme *)theme title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(PXLActionSheetTapBlock)tapBlock {
	
	PXLActionSheet *actionSheet = [[PXLActionSheet alloc] initWithTheme:theme title:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles tapBlock:tapBlock];
	[actionSheet showInView:view];
	return actionSheet;
}

- (instancetype)initWithTheme:(PXLActionSheetTheme *)theme title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(PXLActionSheetTapBlock)tapBlock {
	
	self = [super init];
	if (self) {
		_title = title;
		_cancelButtonTitle = cancelButtonTitle;
		_destructiveButtonTitle = destructiveButtonTitle;
		_otherButtonTitles = otherButtonTitles;
		_tapBlock = tapBlock;

		_visibilty = PXLActionSheetVisibilityHidden;
		_theme = theme;
		
		if (! self.cancelButtonTitle) {
			[[NSException exceptionWithName:@"PXLActionSheetException" reason:@"Missing cancel button title." userInfo:nil] raise];
		}
		
		self.backgroundColor = self.theme.backdropShadowColor;
		self.isAccessibilityElement = NO;
	}
	
	return self;
}

- (void)addButtonSubViewsToView:(UIView *)view {
	__block CGFloat yPos = CGRectGetMaxY(self.titleLabel.frame) ? CGRectGetMaxY(self.titleLabel.frame) : PXLActionSheetButtonVerticalPadding;
	
	[self.otherButtonTitles enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL *stop) {
		UIButton *newButton = ({
			UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
			
			if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
				button.frame = CGRectMake(PXLActionSheetButtonVerticalPadding, yPos, CGRectGetWidth(view.frame) - (PXLActionSheetButtonHorizontalPadding * 2), PXLActionSheetButtonHeight);
			} else {
				button.frame = CGRectMake(0, yPos, CGRectGetWidth(view.frame), PXLActionSheetButtonHeight);
			}
			
			[button setTag:idx];
			[button setTitle:buttonTitle forState:UIControlStateNormal];
			[button setTitleColor:self.theme.normalButtonTextColor forState:UIControlStateNormal];
			[button setTitleColor:self.theme.normalButtonHighlightTextColor forState:UIControlStateHighlighted];
			[button setBackgroundColor:self.theme.normalButtonColor forState:UIControlStateNormal];
			[button setBackgroundColor:self.theme.normalButtonHighlightColor forState:UIControlStateHighlighted];
			
			button.titleLabel.font = self.theme.buttonFont;
			button.layer.masksToBounds = YES;
			
			NSInteger lastButtonIndex = [self.otherButtonTitles count] - 1;
			if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
				if (idx == 0) {
					[button applyCornerRadiusMaskForCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadius:self.theme.cornerRadius];
				} else if (idx == lastButtonIndex && !self.destructiveButtonTitle) {
					[button applyCornerRadiusMaskForCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight withRadius:self.theme.cornerRadius];
				} else if (lastButtonIndex == 0 && !self.destructiveButtonTitle) {
					[button applyCornerRadiusMaskForCorners:UIRectCornerAllCorners withRadius:self.theme.cornerRadius];
				}
			}
			
			if (idx != lastButtonIndex) {
				[button addSubview:[self buttonDividerAtYPos:CGRectGetMaxY(button.bounds) - 0.75]];
			} else {
				if (self.destructiveButtonTitle) {
					[button addSubview:[self buttonDividerAtYPos:CGRectGetMaxY(button.bounds) - 0.75]];
				}
			}
			
			[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
			button;
		});
		
		[view addSubview:newButton];
		yPos = CGRectGetMaxY(newButton.frame);
	}];
	
	if (self.destructiveButtonTitle) {
		UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
			newButton.frame = CGRectMake(PXLActionSheetButtonHorizontalPadding, yPos, CGRectGetWidth(view.frame) - (PXLActionSheetButtonHorizontalPadding * 2), PXLActionSheetButtonHeight);
		} else {
			newButton.frame = CGRectMake(0, yPos, CGRectGetWidth(view.frame), PXLActionSheetButtonHeight);
		}
		
		[newButton setTag:-2];
		[newButton setTitle:self.destructiveButtonTitle forState:UIControlStateNormal];
		[newButton setTitleColor:self.theme.destructiveButtonTextColor forState:UIControlStateNormal];
		[newButton setTitleColor:self.theme.destructiveButtonHighlightTextColor forState:UIControlStateHighlighted];
		[newButton setBackgroundColor:self.theme.destructiveButtonColor forState:UIControlStateNormal];
		[newButton setBackgroundColor:self.theme.destructiveButtonHighlightColor forState:UIControlStateHighlighted];
		newButton.titleLabel.font = self.theme.buttonFont;
		
		[newButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
		newButton.layer.masksToBounds = NO;
		
		if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
			if (self.otherButtonTitles.count > 0) {
				[newButton applyCornerRadiusMaskForCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight withRadius:self.theme.cornerRadius];
			} else {
				[newButton applyCornerRadiusMaskForCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerTopRight withRadius:self.theme.cornerRadius];
			}
		}
		
		[view addSubview:newButton];
		yPos = CGRectGetMaxY(newButton.frame);
	}
	
	self.cancelButton = ({
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		
		if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
			button.frame = CGRectMake(PXLActionSheetButtonHorizontalPadding, yPos + PXLActionSheetButtonVerticalPadding, CGRectGetWidth(view.frame) - (PXLActionSheetButtonHorizontalPadding * 2), PXLActionSheetButtonHeight);
		} else {
			button.frame = CGRectMake(0, yPos + PXLActionSheetButtonVerticalPadding, CGRectGetWidth(view.frame), PXLActionSheetButtonHeight);
		}
		
		[button setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
		[button setTitleColor:self.theme.normalButtonTextColor forState:UIControlStateNormal];
		[button setTitleColor:self.theme.normalButtonHighlightTextColor forState:UIControlStateHighlighted];
		[button setBackgroundColor:self.theme.normalButtonColor forState:UIControlStateNormal];
		[button setBackgroundColor:self.theme.normalButtonHighlightColor forState:UIControlStateHighlighted];
		
		button.titleLabel.font = self.theme.buttonFont;
		
		[button addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		
		if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
			button.layer.cornerRadius = self.theme.cornerRadius;
			button.layer.masksToBounds = YES;
		}
		
		button;
	});
	
	[view addSubview:self.cancelButton];
}

- (UIView *)buttonDividerAtYPos:(CGFloat)yPos {
	return ({
		UIView *view = [[UIView alloc] init];
		
		if (self.theme.actionSheetStyle == PXLActionSheetStyleRounded) {
			view.frame = CGRectMake(0, yPos, CGRectGetWidth(self.containerView.bounds) - (PXLActionSheetButtonHorizontalPadding * 2), 0.75);
		} else {
			view.frame = CGRectMake(0, yPos, CGRectGetWidth(self.containerView.bounds), 0.75);
		}
		
		view.backgroundColor = self.theme.borderColor;
		view;
	});
}

#pragma mark - Animations

- (void)showInView:(UIView *)view {
	
	self.containerView = view;
	self.frame = self.containerView.bounds;
	
	// --- SETUP buttons
	_containerSnapShotView = [_containerView snapshotViewAfterScreenUpdates:YES];
	_containerSnapShotView.isAccessibilityElement = YES;
	_containerSnapShotView.accessibilityLabel = self.cancelButtonTitle;
	[self addSubview:_containerSnapShotView];
	
	[_containerSnapShotView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonTapped:)]];
	
	CGFloat actionSheetHeight = [self heightForActionSheetWithNumberOfButtons:[_otherButtonTitles count]];
	
	_actionSheetBackgroundView = ({
		UIView *view = [[UIView alloc] initWithFrame:({
			CGRect frame = self.bounds;
			frame.size.width = CGRectGetWidth(_containerView.bounds);
			frame.size.height = actionSheetHeight;
			frame.origin.x = 0;
			frame.origin.y = CGRectGetHeight(_containerView.bounds) - actionSheetHeight;
			frame;
		})];
		
		view.backgroundColor = self.theme.backgroundColor;
		view;
	});
	
	[self addSubview:_actionSheetBackgroundView];
	
	if (_title) {
		_titleLabel = ({
			UILabel *label = [[UILabel alloc] initWithFrame:({
				CGRect frame = CGRectZero;
				frame = CGRectMake(0, 0, CGRectGetWidth(_actionSheetBackgroundView.bounds), [self heightForActionSheetTitleLabel]);
				frame;
			})];
			
			label.text = _title;
			label.font = self.theme.titleFont;
			label.numberOfLines = 0;
			label.textAlignment = NSTextAlignmentCenter;
			label.textColor = self.theme.titleTextColor;
			
			label;
		});
		_titleLabel.isAccessibilityElement = YES;
		_titleLabel.accessibilityLabel = self.title;
		
		[_actionSheetBackgroundView addSubview:_titleLabel];
	}
	
	[self addButtonSubViewsToView:_actionSheetBackgroundView];
	// --- SETUP buttons
	
	CGRect actionSheetBackgroundViewFinalFrame = self.actionSheetBackgroundView.frame;
	
	self.actionSheetBackgroundView.frame = CGRectMake(CGRectGetMinX(self.actionSheetBackgroundView.frame), CGRectGetHeight(self.containerView.frame), CGRectGetWidth(self.actionSheetBackgroundView.frame), CGRectGetHeight(self.actionSheetBackgroundView.frame));
	
	[self.containerView addSubview:self];
	
	[UIView animateWithDuration:self.theme.animationSpeed / 2 animations:^{
		self.containerSnapShotView.layer.opacity = 0.6;
	}];
	
	[UIView animateWithDuration:self.theme.animationSpeed delay:0 usingSpringWithDamping:self.theme.animationSpringDamping initialSpringVelocity:self.theme.animationSpringVelocity options:kNilOptions animations:^{
		self.actionSheetBackgroundView.frame = actionSheetBackgroundViewFinalFrame;
	} completion:^(BOOL finished) {
		if (finished) {
			self.visibilty = PXLActionSheetVisibilityVisible;
			if ([self.delegate respondsToSelector:@selector(actionSheet:didChangeVisibility:)]) {
				[self.delegate actionSheet:self didChangeVisibility:self.visibilty];
			}
		}
	}];
}

- (void)dismissFromView:(UIView *)view {
	
	[UIView animateWithDuration:self.theme.animationSpeed / 4 animations:^{
		self.containerSnapShotView.layer.opacity = 1.0;
		self.actionSheetBackgroundView.frame = CGRectMake(CGRectGetMinX(self.actionSheetBackgroundView.frame), CGRectGetHeight(self.containerView.frame), CGRectGetWidth(self.actionSheetBackgroundView.frame), CGRectGetHeight(self.actionSheetBackgroundView.frame));
	} completion:^(BOOL finished) {
		if (finished) {
			[self removeFromSuperview];
			self.visibilty = PXLActionSheetVisibilityHidden;
			if ([self.delegate respondsToSelector:@selector(actionSheet:didChangeVisibility:)]) {
				[self.delegate actionSheet:self didChangeVisibility:self.visibilty];
			}
		}
	}];
}

#pragma mark - Helpers

- (CGFloat)heightForActionSheetTitleLabel {
	CGSize maxSize = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
	
	CGRect labelRect = [self.title boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName : self.theme.titleFont} context:nil];
	
	return CGRectGetHeight(labelRect) + (PXLActionSheetTitlePadding * 2);
}

- (CGFloat)heightForActionSheetWithNumberOfButtons:(NSInteger)numberOfButtons {
	CGFloat height = 0.0f;
	
	NSInteger initialNumberOfButtons = numberOfButtons;
	
	numberOfButtons++; // Cancel Button
	if (self.destructiveButtonTitle) {
		numberOfButtons++;
	}
	
	height += PXLActionSheetButtonHeight * numberOfButtons;
	
	numberOfButtons = numberOfButtons - initialNumberOfButtons;
	
	if (! self.destructiveButtonTitle) {
		numberOfButtons++;
	}
	
	height += PXLActionSheetButtonVerticalPadding * numberOfButtons;
	height += (self.title) ? [self heightForActionSheetTitleLabel] : 0;
	
	return height;
}

#pragma mark - Taps

- (void)cancelButtonTapped:(UITapGestureRecognizer *)sender {
	if (self.tapBlock) {
		self.tapBlock(self, -1);
	}
	
	[self dismissFromView:self];
}

- (void)buttonTapped:(UIButton *)sender {
	if (self.tapBlock) {
		self.tapBlock(self, sender.tag);
	}
	
	[self dismissFromView:self.containerView];
}

@end
