//
//  PXLActionSheet.h
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