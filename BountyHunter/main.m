//
//  main.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/5/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FugitiveAppDelegatePad.h"
#import "FugitiveAppDelegatePhone.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        // iPad and iPhone have their own app delegates respectively.
        NSString *delegateClassName = 
            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ?
            NSStringFromClass([FugitiveAppDelegatePad class]) : 
            NSStringFromClass([FugitiveAppDelegatePhone class]);
        
        return UIApplicationMain(argc, argv, nil, delegateClassName);
    }
}
