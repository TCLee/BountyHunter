//
//  FugitiveListViewController.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/6/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FugitiveListViewController : UITableViewController
<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
