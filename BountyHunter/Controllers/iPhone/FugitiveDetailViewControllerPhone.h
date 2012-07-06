//
//  FugitiveDetailViewController.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/6/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class Fugitive;

@interface FugitiveDetailViewControllerPhone : UITableViewController
<CLLocationManagerDelegate>

@property (strong, nonatomic) Fugitive *fugitive;

@property (strong, nonatomic, readonly) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *idCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bountyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *capturedDateCell;
@property (weak, nonatomic) IBOutlet UISwitch *capturedSwitch;

- (IBAction)capturedSwitchChanged:(id)sender;
@end
