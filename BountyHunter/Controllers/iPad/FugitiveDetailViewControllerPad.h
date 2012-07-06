//
//  FugitiveDetailViewControllerPad.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/12/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Fugitive;

@interface FugitiveDetailViewControllerPad : UIViewController
<UISplitViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) Fugitive *fugitive;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *bountyLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIView *lastSeenView;
@property (weak, nonatomic) IBOutlet UILabel *lastSeenCoordLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastSeenDescLabel;

@end
