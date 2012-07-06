//
//  FugitiveAnnotation.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/11/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitiveAnnotation.h"

@implementation FugitiveAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
    }
    return self;
}

@end
