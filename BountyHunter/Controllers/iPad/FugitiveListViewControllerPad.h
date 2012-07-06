//
//  FugitiveListViewControllerPad.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/12/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveListViewController.h"

@class FugitiveDetailViewControllerPad;

@interface FugitiveListViewControllerPad : FugitiveListViewController

@property (weak, nonatomic) FugitiveDetailViewControllerPad *detailViewController;

/* Saves the selected index path on the table view. 
   The index path of the table view will be reset to nil, 
   everytime the popover is hidden and shown.*/
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end
