//
//  PXLAppDelegate.m
//  Example
//
//  Created by Jason Silberman on 7/30/14.
//  Copyright (c) 2014 Jason Silberman. All rights reserved.
//

#import "PXLAppDelegate.h"
#import "PXLViewController.h"

@implementation PXLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[PXLViewController alloc] init]];
	
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	return YES;
}
@end
