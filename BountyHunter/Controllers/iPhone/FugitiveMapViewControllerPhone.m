//
//  FugitiveMapViewController.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/11/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveMapViewControllerPhone.h"
#import "Fugitive.h"
#import "FugitiveAnnotation.h"

@interface FugitiveMapViewControllerPhone ()
- (void)showFugitiveLocationInMap;
@end

@implementation FugitiveMapViewControllerPhone

@synthesize fugitive = _fugitive;
@synthesize mapView = _mapView;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    self.fugitive = nil;
    
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showFugitiveLocationInMap];
}

#pragma mark - Device Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Map View

- (void)showFugitiveLocationInMap
{
    // Zoom map in on where the fugitive was captured.
    if ([self.fugitive.captured boolValue]) {
        CLLocationCoordinate2D fugitiveLocation = CLLocationCoordinate2DMake([self.fugitive.capturedLat doubleValue], 
                                                                             [self.fugitive.capturedLon doubleValue]);
        MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.005, 0.005);
        MKCoordinateRegion mapRegion = MKCoordinateRegionMake(fugitiveLocation, mapSpan);
        
        // Add fugitive pin to map.
        [self.mapView addAnnotation:[[FugitiveAnnotation alloc] 
                                     initWithCoordinate:fugitiveLocation 
                                     title:self.fugitive.name 
                                     subtitle:self.fugitive.desc]];

        
        [self.mapView setRegion:mapRegion animated:YES];
    }
}

#pragma mark - Map Delegate

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    // Open the map callout view automatically for the user.        
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    [mapView selectAnnotation:annotationView.annotation animated:YES];
}

@end
