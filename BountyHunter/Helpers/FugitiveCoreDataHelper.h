//
//  FugitiveCoreDataHelper.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/7/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FugitiveCoreDataHelper : NSObject

+ (NSFetchedResultsController *)fetchedResultsControllerForDelegate:(id<NSFetchedResultsControllerDelegate>)theDelegate managedObjectContext:(NSManagedObjectContext *)managedObjectContext predicate:(NSPredicate *)aPredicate cacheName:(NSString *)cacheName;

@end
