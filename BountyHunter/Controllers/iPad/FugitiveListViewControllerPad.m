//
//  FugitiveListViewControllerPad.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/12/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveListViewControllerPad.h"
#import "FugitiveDetailViewControllerPad.h"
#import "Fugitive.h"
#import "FugitiveCoreDataHelper.h"

@implementation FugitiveListViewControllerPad

@synthesize detailViewController = _detailViewController;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - View Lifecycle

/* Do any additional setup after loading the view. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the table view's background color to look more like
    // a sheet of note paper.
    self.tableView.backgroundColor = [[UIColor alloc] initWithRed:(236.0/255.0) 
                                                            green:(231.0/255.0) 
                                                             blue:(158.0/255.0) 
                                                            alpha:1.0];
            
    // Select the first fugitive by default. Otherwise, there will
    // be no fugitive selected and detail view will show nothing.
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];    
        
    // Get the reference to the Detail View Controller from the Split View Controller.
    self.detailViewController = (FugitiveDetailViewControllerPad *)[self.splitViewController.viewControllers.lastObject topViewController];    
    self.detailViewController.fugitive = [self.fetchedResultsController objectAtIndexPath:self.selectedIndexPath];    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    // Highlight the previously selected fugitive.
    [self.tableView selectRowAtIndexPath:self.selectedIndexPath 
                                animated:YES 
                          scrollPosition:UITableViewScrollPositionMiddle];    
}

/* Release any strong references here. */
- (void)viewDidUnload
{    
    self.selectedIndexPath = nil;
    [super viewDidUnload];
}

#pragma mark - Device Rotation

/* iPad allows rotation to all orientations. */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table View Delegate

/* Display selected fugitive on detail view. */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    
    // Pass the Fugitive model to the Detail view controller.
    Fugitive *theFugitive = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    self.detailViewController.fugitive = theFugitive;    
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (nil == _fetchedResultsController) {        
        // We want all the Fugitives to be returned in the result set.
        _fetchedResultsController = [FugitiveCoreDataHelper 
                                     fetchedResultsControllerForDelegate:self 
                                     managedObjectContext:self.managedObjectContext                                      
                                     predicate:nil
                                     cacheName:@"AllFugitives.cache"];
    }
    return _fetchedResultsController;
}

@end
