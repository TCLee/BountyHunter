//
//  FugitiveAnnotation.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/11/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FugitiveAnnotation : NSObject
<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

@end
