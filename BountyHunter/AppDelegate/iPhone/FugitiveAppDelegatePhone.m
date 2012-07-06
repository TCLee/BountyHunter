//
//  FugitiveAppDelegatePhone.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/7/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveAppDelegatePhone.h"
#import "FugitiveListViewController.h"
#import "CapturedListViewControllerPhone.h"

@implementation FugitiveAppDelegatePhone

/* Override point for customization after application launch. */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    // Pass the managed object context to the top-level view controllers.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *fugitiveNavigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:0];
    FugitiveListViewController *fugitiveListViewController = (FugitiveListViewController *)fugitiveNavigationController.topViewController;
    fugitiveListViewController.managedObjectContext = self.managedObjectContext;
    
    UINavigationController *capturedNavigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:1];
    CapturedListViewControllerPhone *capturedListViewController = (CapturedListViewControllerPhone *)capturedNavigationController.topViewController;
    capturedListViewController.managedObjectContext = self.managedObjectContext;

    return YES;
}

@end
