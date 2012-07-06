//
//  Fugitive.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/18/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fugitive : NSManagedObject

@property (nonatomic, retain) NSNumber * captured;
@property (nonatomic, retain) NSDate * captdate;
@property (nonatomic, retain) NSNumber * capturedLat;
@property (nonatomic, retain) NSNumber * lastSeenLat;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * capturedLon;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * lastSeenLon;
@property (nonatomic, retain) NSDecimalNumber * bounty;
@property (nonatomic, retain) NSString * lastSeenDesc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * fugitiveID;

@end
