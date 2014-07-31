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

///------------------------------------------
/// @name Creating and Showing Action Sheets
///------------------------------------------


/**
 Creates a PXLActionSheet and shows it.
 
 @param view The view to show the action sheet in
 @param theme The PXLActionSheetTheme to use
 @param title The title of the action sheet
 @param cancelButtonTitle The title of the cancel button
 @param destructiveButtonTitle The title of the destructive button
 @param otherButtonTitles An `NSArray` of button titles
 @param tapBlock The tap block to be called when a button was pressed
 
 @return The PXLActionSheet created
 */
+ (instancetype)showInView:(UIView *)view withTheme:(PXLActionSheetTheme *)theme title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(PXLActionSheetTapBlock)tapBlock;

/**
 Creates a PXLActionSheet.
 
 @param theme The PXLActionSheetTheme to use
 @param title The title of the action sheet
 @param cancelButtonTitle The title of the cancel button
 @param destructiveButtonTitle The title of the destructive button
 @param otherButtonTitles An `NSArray` of button titles
 @param tapBlock The tap block to be called when a button was pressed
 
 @return The PXLActionSheet created
 */
- (instancetype)initWithTheme:(PXLActionSheetTheme *)theme title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(PXLActionSheetTapBlock)tapBlock;

/**
 Show the receiver in the given view.
 
 @param view The view the PXLActionSheet is shown in
 */
- (void)showInView:(UIView *)view;

///------------------
/// @name Properties
///------------------

/**
 The visibilty of the action sheet.
 */
@property (nonatomic) PXLActionSheetVisibility visibilty;

/**
 The delegate of the action sheet.
 */
@property (nonatomic, weak) id <PXLActionSheetDelegate> delegate;

@end

@protocol PXLActionSheetDelegate <NSObject>

@optional

/**
 The delegate method to be called when the action sheet changed visibility.
 
 @param actionSheet The PXLActionSheet
 @param visibilty The new visibilty of the action sheet
 */
- (void)actionSheet:(PXLActionSheet *)actionSheet didChangeVisibility:(PXLActionSheetVisibility)visibilty;

@end