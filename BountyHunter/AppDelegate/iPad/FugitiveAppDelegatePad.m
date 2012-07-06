//
//  FugitiveAppDelegatePad.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/12/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveAppDelegatePad.h"
#import "FugitiveListViewControllerPad.h"
#import "FugitiveDetailViewControllerPad.h"

@implementation FugitiveAppDelegatePad

/* Override point for customization after application launch. */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [super application:application didFinishLaunchingWithOptions:launchOptions];

    // The detail view controller will be the delegate for the split view controller.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *detailNavigationController = [splitViewController.viewControllers lastObject];
    FugitiveDetailViewControllerPad *detailController = (FugitiveDetailViewControllerPad *)detailNavigationController.topViewController;
    splitViewController.delegate = detailController;    

    // Pass the Core Data's managed object context to the master view controller.
    UINavigationController *masterNavigationController = [splitViewController.viewControllers objectAtIndex:0];
    FugitiveListViewControllerPad *mastercontroller = (FugitiveListViewControllerPad *)masterNavigationController.topViewController;
    mastercontroller.managedObjectContext = self.managedObjectContext;    
    
    // Set a custom background texture for the navigation bar.
    UIImage *navigationBarImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"navbar_texture" ofType:@"png"]];
    [masterNavigationController.navigationBar setBackgroundImage:navigationBarImage forBarMetrics:UIBarMetricsDefault];
    [detailNavigationController.navigationBar setBackgroundImage:navigationBarImage forBarMetrics:UIBarMetricsDefault];
        
    return YES;
}

@end
