//
//  FugitiveDescriptionViewController.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/7/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveDescriptionViewControllerPhone.h"
#import "Fugitive.h"

@interface FugitiveDescriptionViewControllerPhone ()
- (void)configureView;
@end

@implementation FugitiveDescriptionViewControllerPhone

@synthesize fugitive = _fugitive;
@synthesize descriptionTextView = _descriptionTextView;

#pragma mark - Fugitive Model

- (void)setFugitive:(Fugitive *)newFugitive
{
    if (_fugitive != newFugitive) {
        _fugitive = newFugitive;
        
        // Update the view when model has changed.
        [self configureView];
    }
}

/* Update the user interface for the detail item. */
- (void)configureView
{
    if (self.fugitive) {
        self.descriptionTextView.text = self.fugitive.desc;
    }
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
}

- (void)viewDidUnload
{
    self.fugitive = nil;
    
    [super viewDidUnload];
}

#pragma mark - Device Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
