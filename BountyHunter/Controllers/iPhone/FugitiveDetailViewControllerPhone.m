//
//  FugitiveDetailViewController.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/6/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveDetailViewControllerPhone.h"
#import "FugitiveDescriptionViewControllerPhone.h"
#import "FugitivePhotoViewControllerPhone.h"
#import "FugitiveMapViewControllerPhone.h"
#import "Fugitive.h"

@interface FugitiveDetailViewControllerPhone ()

@property (strong, nonatomic, readwrite) CLLocationManager *locationManager;

- (void)configureView;
- (void)stopUpdatingLocation;
- (void)setFugitive:(Fugitive *)theFugitive captured:(BOOL)captured;

@end

@implementation FugitiveDetailViewControllerPhone

@synthesize fugitive = _fugitive;
@synthesize locationManager = _locationManager;
@synthesize nameCell = _nameCell;
@synthesize idCell = _idCell;
@synthesize bountyCell = _bountyCell;
@synthesize capturedSwitch = _capturedSwitch;
@synthesize capturedDateCell = _capturedDateCell;

#pragma mark - Fugitive Model

- (void)setFugitive:(Fugitive *)newFugitive
{
    if (_fugitive != newFugitive) {
        _fugitive = newFugitive;
        
        // Update the view when model has changed.
        [self configureView];
    }
}

/* Mark fugitive as captured or still on the run. */
- (void)setFugitive:(Fugitive *)theFugitive captured:(BOOL)captured
{
    if (captured) {
        // Make sure we can get user's current location before we
        // allow fugitive to be marked as captured.
        CLLocation *currentLocation = self.locationManager.location;        
        if (currentLocation) {
            theFugitive.captured = [[NSNumber alloc] initWithBool:YES];
            theFugitive.captdate = [[NSDate alloc] init];
            theFugitive.capturedLat = [[NSNumber alloc] initWithDouble:currentLocation.coordinate.latitude];
            theFugitive.capturedLon = [[NSNumber alloc] initWithDouble:currentLocation.coordinate.longitude];            
        } else {
            [self setFugitive:theFugitive captured:NO];
        }
    } else {
        theFugitive.captured = [[NSNumber alloc] initWithBool:NO];
        theFugitive.captdate = nil;
        theFugitive.capturedLat = nil;
        theFugitive.capturedLon = nil;  
    }
}

/* Update the user interface for the detail item. */
- (void)configureView
{
    if (self.fugitive) {
        self.nameCell.detailTextLabel.text = self.fugitive.name;
        self.idCell.detailTextLabel.text = [self.fugitive.fugitiveID stringValue];
        
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;                
        self.bountyCell.detailTextLabel.text = [currencyFormatter stringFromNumber:self.fugitive.bounty];
        
        [self.capturedSwitch setOn:[self.fugitive.captured boolValue] animated:YES];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;                
        self.capturedDateCell.detailTextLabel.text = [dateFormatter stringFromDate:self.fugitive.captdate];
    }
}

#pragma mark - View Lifecycle

- (void)viewDidUnload
{
    self.fugitive = nil;
    self.locationManager = nil;
        
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; 
    
    // Update the view with the model's data.
    [self configureView];
    
    // Attempt to get the user's current location.
    // User's current location is used to mark where
    // the fugitive was captured.
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self stopUpdatingLocation];
}

#pragma mark - Device Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Storyboard Segue

/* Pass the Fugitive model to the destination view controllers. */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFugitiveDescription"]) {
        FugitiveDescriptionViewControllerPhone *descriptionViewController = [segue destinationViewController];
        descriptionViewController.fugitive = self.fugitive;
    } else if ([[segue identifier] isEqualToString:@"ShowFugitivePhoto"]) {
        FugitivePhotoViewControllerPhone *photoViewController = [segue destinationViewController];
        photoViewController.fugitive = self.fugitive;
    } else if ([[segue identifier] isEqualToString:@"ShowFugitiveMap"]) {
        FugitiveMapViewControllerPhone *mapViewController = [segue destinationViewController];
        mapViewController.fugitive = self.fugitive;        
    }
}

#pragma mark - UI Actions

- (IBAction)capturedSwitchChanged:(id)sender 
{
    // Update the model.
    [self setFugitive:self.fugitive 
             captured:self.capturedSwitch.isOn];    
        
    // Update the view.
    [self configureView];
    [self.tableView reloadData];
}

#pragma mark - Location Manager

- (CLLocationManager *)locationManager
{
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void) stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

#pragma mark - Location Manager Delegate

/* Core Location has returned with a valid location of the user. */
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    // We've got the user's location, so we can stop the location manager.
    [self stopUpdatingLocation];
    
    //TODO: Comment out later!
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Success" 
//                                                        message:[[NSString alloc] initWithFormat: @"Latitude: %.3f, Longitude: %.3f", newLocation.coordinate.latitude, newLocation.coordinate.longitude]
//                                                       delegate:nil 
//                                              cancelButtonTitle:@"OK" 
//                                              otherButtonTitles:nil];
//    [alertView show];
}

/* Error - Core Location can't get a fix on our position. */
-(void)locationManager:(CLLocationManager *)manager 
      didFailWithError:(NSError *)error
{            
    // Stop the location manager.
    [self stopUpdatingLocation];
        
    // Show alert view with error message to user.
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Error" 
                                                        message:@"Can't get a fix on your current location." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
