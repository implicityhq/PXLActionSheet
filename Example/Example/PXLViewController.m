//
//  PXLViewController.m
//  Example
//
//  Created by Jason Silberman on 7/30/14.
//  Copyright (c) 2014 Jason Silberman. All rights reserved.
//

#import "PXLViewController.h"
#import "PXLActionSheet.h"
#import "PXLActionSheetTheme.h"

@interface PXLViewController ()

@end

@implementation PXLViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"PXLActionSheet";
	
	self.view.backgroundColor = [UIColor colorWithRed:0.082 green:0.541 blue:0.792 alpha:1];
	
	UILabel *label = [[UILabel alloc] init];
	label.translatesAutoresizingMaskIntoConstraints = NO;
	label.text = @"Tap to show";
	label.font = [UIFont fontWithName:@"Avenir" size:20];
	label.textColor = [UIColor whiteColor];
	label.userInteractionEnabled = YES;
	[self.view addSubview:label];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[label addGestureRecognizer:tap];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer {
	if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
		
		[PXLActionSheet showInView:self.view withTheme:[PXLActionSheetTheme defaultTheme] title:@"A new customizable replacement for UIActionSheet." cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"Custom Fonts", @"Custom Colors", @"And More!"] tapBlock:^(PXLActionSheet *actionSheet, NSInteger tappedButtonIndex) {
			NSLog(@"tapped at %ld", (long)tappedButtonIndex);
		}];
		
	}
}

@end
