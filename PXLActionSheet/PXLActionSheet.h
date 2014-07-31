//
//  PXLActionSheet.h
//  Example
//
//  Created by Jason Silberman on 7/30/14.
//  Copyright (c) 2014 Jason Silberman. All rights reserved.
//

@class PXLActionSheet;
@class PXLActionSheetTheme;

typedef NS_ENUM(NSInteger, PXLActionSheetVisibility) {
    PXLActionSheetVisibilityVisible,
    PXLActionSheetVisibilityHidden
};

typedef void (^PXLActionSheetTapBlock) (PXLActionSheet * actionSheet, NSInteger tappedButtonIndex);

NSString *NSStringFromActionSheetVisibility(PXLActionSheetVisibility visibility);

@protocol PXLActionSheetDelegate;

@interface PXLActionSheet : UIView

@property (assign, nonatomic, readonly) NSInteger cancelButtonIndex;
@property (assign, nonatomic, readonly) NSInteger destructiveButtonIndex;
@property (copy, nonatomic) PXLActionSheetTapBlock tapBlock;
@property (nonatomic) PXLActionSheetVisibility visibilty;
@property (nonatomic, weak) id <PXLActionSheetDelegate> delegate;

+ (void)showInView:(UIView *)view withTheme:(PXLActionSheetTheme *)theme title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(PXLActionSheetTapBlock)tapBlock;

- (void)showInView:(UIView *)view;

@end

@protocol PXLActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(PXLActionSheet *)actionSheet didChangeVisibility:(PXLActionSheetVisibility)visibilty;

@end