//
//  FugitiveDescriptionViewController.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/7/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Fugitive;

@interface FugitiveDescriptionViewControllerPhone : UITableViewController

@property (strong, nonatomic) Fugitive *fugitive;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
