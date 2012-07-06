//
//  FugitiveMapViewController.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/11/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Fugitive;

@interface FugitiveMapViewControllerPhone : UIViewController
<MKMapViewDelegate>

@property (strong, nonatomic) Fugitive *fugitive;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
