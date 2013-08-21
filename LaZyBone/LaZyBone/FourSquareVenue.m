//
//  FourSquareVenue.m
//  GoogleMapPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "FourSquareVenue.h"

@implementation FourSquareVenue


- (FourSquareVenue *) initWithID:(NSString *)venueID Name:(NSString *)name Latitude:(float)latitude Longitude:(float)longitude andLikes:(int)likeCount{
    self = [super init];
    _venueID = venueID;
    _name = name;
    _latitude = latitude;
    _longitude = longitude;
    _likes = likeCount;
    return self;
}

@end
