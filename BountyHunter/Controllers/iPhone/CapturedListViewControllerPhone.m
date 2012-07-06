//
//  CapturedListViewController.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/6/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "CapturedListViewControllerPhone.h"
#import "FugitiveCoreDataHelper.h"

@implementation CapturedListViewControllerPhone

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (nil == _fetchedResultsController) {
        // We only want the Fugitives that have been captured already.
        _fetchedResultsController = [FugitiveCoreDataHelper 
                                     fetchedResultsControllerForDelegate:self 
                                     managedObjectContext:self.managedObjectContext 
                                     predicate:[NSPredicate predicateWithFormat:@"captured == YES"] 
                                     cacheName:@"Captured.cache"];
    }
    return _fetchedResultsController;
}

@end
