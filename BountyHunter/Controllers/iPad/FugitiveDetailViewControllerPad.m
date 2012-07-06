//
//  FugitiveDetailViewControllerPad.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/12/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FugitiveDetailViewControllerPad.h"
#import "Fugitive.h"
#import "FugitiveAnnotation.h"

#define DegreesToRadians(degrees) ((M_PI * degrees) / 180.0)

@interface FugitiveDetailViewControllerPad ()

@property (assign, nonatomic) BOOL viewWillRotate;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)updateView;
- (void)showFugitiveLocationInMap;
- (void)resizeLabelToFitText:(UILabel *)label;
@end

@implementation FugitiveDetailViewControllerPad

@synthesize viewWillRotate = _viewWillRotate;

@synthesize fugitive = _fugitive;
@synthesize imageView = _imageView;
@synthesize mapViewContainer = _mapViewContainer;
@synthesize mapView = _mapView;
@synthesize descriptionView = _descriptionView;
@synthesize idLabel = _idLabel;
@synthesize bountyLabel = _bountyLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize lastSeenView = _lastSeenView;
@synthesize lastSeenCoordLabel = _lastSeenCoordLabel;
@synthesize lastSeenDescLabel = _lastSeenDescLabel;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Helper Methods

/* Resizes given label to fit its text. */
- (void)resizeLabelToFitText:(UILabel *)label
{
    CGSize newSize = [label.text sizeWithFont:label.font 
                            constrainedToSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) 
                                lineBreakMode:UILineBreakModeWordWrap];    
    
    CGRect newFrame = CGRectMake(label.frame.origin.x, 
                                 label.frame.origin.y, 
                                 label.frame.size.width, 
                                 newSize.height);    
    label.frame = newFrame;
}

- (void)setShadowForView:(UIView *)view
{
    view.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    view.layer.shadowOpacity = 0.75;
}

#pragma mark - Fugitive Model

- (void)setFugitive:(Fugitive *)newFugitive
{
    if (_fugitive != newFugitive) {
        _fugitive = newFugitive;
        
        // Update the view when the model has changed.
        [self updateView];
    }
    
    // Hide the split view's popover after user has selected an item from it.
    if (nil != self.masterPopoverController) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

/* Update the view based on the model's data. */
- (void)updateView
{
    // If no model to display in view, do nothing.
    if (nil == self.fugitive) { return; }

    // Fugitive name as the title on the navigation bar.
    self.navigationItem.title = self.fugitive.name;
    
    // Fugitive photo.
    if (self.fugitive.image) {
        self.imageView.image = [[UIImage alloc] initWithData:self.fugitive.image];
    } else {
        self.imageView.image = [UIImage imageNamed:@"silhouette.png"];
    }
    
    self.idLabel.text = [self.fugitive.fugitiveID stringValue];
    self.descriptionLabel.text = self.fugitive.desc;
    [self resizeLabelToFitText:self.descriptionLabel];
    
    // Fugitive bounty formatted as currency string.
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;                
    self.bountyLabel.text = [currencyFormatter stringFromNumber:self.fugitive.bounty];
    
    // Fugitive last seen coordinates and description.
    if (self.fugitive.lastSeenDesc) {
        self.lastSeenCoordLabel.text = [[NSString alloc] initWithFormat:@"%6.3f, %6.3f", 
                                        [self.fugitive.lastSeenLat doubleValue], 
                                        [self.fugitive.lastSeenLon doubleValue]];
        self.lastSeenDescLabel.text = self.fugitive.lastSeenDesc;
    } else {
        NSString *noSightingString = NSLocalizedString(@"No reported sighting.", @"");
        self.lastSeenCoordLabel.text = noSightingString;
        self.lastSeenDescLabel.text = noSightingString;
    }
    [self resizeLabelToFitText:self.lastSeenDescLabel];
    
    // Fugitive location is marked on the map view.
    [self showFugitiveLocationInMap];
}

/* Shows the selected fugitive's last seen location as a 
   pin on the map. */
- (void)showFugitiveLocationInMap
{
    // If no last known location for Fugitive, reset back to original world map.
    if (!self.fugitive.lastSeenLat || 
        !self.fugitive.lastSeenLon || 
        !self.fugitive.lastSeenDesc) {
        
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView setRegion:MKCoordinateRegionForMapRect(MKMapRectWorld) animated:YES];
        return;
    }
    
    // Zoom map in on the fugitive's last seen location.
    CLLocationCoordinate2D fugitiveLocation = CLLocationCoordinate2DMake([self.fugitive.lastSeenLat doubleValue], 
                                                                         [self.fugitive.lastSeenLon doubleValue]);
    MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.005, 0.005);
    [self.mapView setRegion:MKCoordinateRegionMake(fugitiveLocation, mapSpan) animated:YES];
    
    // Add pin to map to mark down fugitive's last seen location.
    // But, first we must remove any previous annotations.
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:[[FugitiveAnnotation alloc] 
                                 initWithCoordinate:fugitiveLocation 
                                 title:self.fugitive.name 
                                 subtitle:nil]];
}


#pragma mark - View Lifecycle

/* Do any additional setup after loading the view. */
- (void)viewDidLoad
{
    [super viewDidLoad];   
    
    // Update view with data from the model.
    [self updateView];

    // Set background textures for the views.
    UIImage *corkTexture = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"corkboard" ofType:@"png"]];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:corkTexture];
    
    UIImage *paperTexture = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"paper_texture" ofType:@"png"]];
    self.descriptionView.backgroundColor = [[UIColor alloc] initWithPatternImage:paperTexture];
    self.lastSeenView.backgroundColor = [[UIColor alloc] initWithPatternImage:paperTexture];

    // Set shadow for the views to give it a 3D effect.
    [self setShadowForView:self.descriptionView];
    [self setShadowForView:self.lastSeenView];
    [self setShadowForView:self.imageView];
    [self setShadowForView:self.mapViewContainer];        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // If view is going to be rotated, then we should NOT
    // apply the rotate transform.
    // The rotate transform will be applied in the
    // willAnimateRotationToInterfaceOrientation method instead.
    if (!self.viewWillRotate) {
        self.descriptionView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(5));
        self.lastSeenView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-5));
        self.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-5));
    }    
    
//    CGSize size = self.descriptionView.bounds.size;
//    NSLog(@"viewWillAppear: Width = %.0f, Height = %.0f", size.width, size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    CGSize size = self.descriptionView.bounds.size;
//    NSLog(@"viewDidAppear: Width = %.0f, Height = %.0f", size.width, size.height);
}

- (void)viewDidUnload
{
    self.fugitive = nil;    
        
    [super viewDidUnload];
}

#pragma mark - Device Rotation

/* iPad will allow rotation to all orientations. */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.viewWillRotate = YES;
    
    // Reset the rotation transforms when device will be rotated.
    // Otherwise, the rotation transforms will go crazy when
    // device has finished rotating to new orientation.
    self.descriptionView.transform = CGAffineTransformIdentity;
    self.lastSeenView.transform = CGAffineTransformIdentity;
    self.imageView.transform = CGAffineTransformIdentity;
    
//    CGSize size = self.descriptionView.bounds.size;
//    NSLog(@"willRotate: Width = %.0f, Height = %.0f", size.width, size.height);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // Apply rotation transform to the views again when device has rotated.
    self.descriptionView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(5));
    self.lastSeenView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-5));
    self.imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DegreesToRadians(-5));
    
//    CGSize size = self.descriptionView.bounds.size;
//    NSLog(@"willAnimateRotation: Width = %.0f, Height = %.0f", size.width, size.height);
}

#pragma mark - Split View Delegate

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Fugitives", @"Fugitives");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Map View Delegate

/* Automatically select the annotation for the user. */
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    [self.mapView selectAnnotation:[[views objectAtIndex:0] annotation] animated:YES];
}

@end
