//
//  FugitiveListViewControllerPhone.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/12/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveListViewControllerPhone.h"
#import "FugitiveDetailViewControllerPhone.h"
#import "FugitiveCoreDataHelper.h"

@implementation FugitiveListViewControllerPhone

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [super viewDidUnload];    
}

#pragma mark - Device Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Storyboard Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFugitiveDetails"]) {
        // Pass the selected Fugitive model to the detail view controller.
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Fugitive *fugitive = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        FugitiveDetailViewControllerPhone *detailViewController = [segue destinationViewController];
        [detailViewController setFugitive:fugitive];
    }
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (nil == _fetchedResultsController) {        
        // We only want the Fugitives that have NOT been captured yet.
        _fetchedResultsController = [FugitiveCoreDataHelper 
                                     fetchedResultsControllerForDelegate:self 
                                     managedObjectContext:self.managedObjectContext                                      
                                     predicate:[NSPredicate predicateWithFormat:@"captured == NO"]
                                     cacheName:@"Fugitives.cache"];
    }
    return _fetchedResultsController;
}

@end
