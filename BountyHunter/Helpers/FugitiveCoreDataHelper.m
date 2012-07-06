//
//  FugitiveCoreDataHelper.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/7/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveCoreDataHelper.h"

@implementation FugitiveCoreDataHelper

+ (NSFetchedResultsController *)fetchedResultsControllerForDelegate:(id<NSFetchedResultsControllerDelegate>)theDelegate managedObjectContext:(NSManagedObjectContext *)managedObjectContext predicate:(NSPredicate *)aPredicate cacheName:(NSString *)cacheName
{
    // Fetching only the "Fugitive" objects.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"Fugitive" 
                                   inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Filter the Fugitive objects based on given condition.
    [fetchRequest setPredicate:aPredicate];
    
    // Sort the fugitives by name in ascending order.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
                                                            initWithFetchRequest:fetchRequest 
                                                            managedObjectContext:managedObjectContext 
                                                            sectionNameKeyPath:nil 
                                                            cacheName:cacheName];
    fetchedResultsController.delegate = theDelegate;
    
	NSError * __autoreleasing error = nil;
	if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. 
        // You should not use this function in a shipping application, although it 
        // may be useful during development. 
	    NSLog(@"Fetch Error: %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return fetchedResultsController;
}

@end
