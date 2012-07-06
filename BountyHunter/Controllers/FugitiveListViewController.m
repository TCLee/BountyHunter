//
//  FugitiveListViewController.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/6/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveListViewController.h"
#import "Fugitive.h"
#import "FugitiveCoreDataHelper.h"

@implementation FugitiveListViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - View Lifecycle

- (void)viewDidUnload
{
    self.fetchedResultsController = nil;
    
    [super viewDidUnload];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FugitiveCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Fugitive *fugitive = [self.fetchedResultsController objectAtIndexPath:indexPath];        
    cell.textLabel.text = fugitive.name;    
    return cell;
}

#pragma mark - Fetched Results Controller Delegate
 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}

@end
