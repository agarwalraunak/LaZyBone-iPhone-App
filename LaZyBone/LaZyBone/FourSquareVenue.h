//
//  FourSquareVenue.h
//  GoogleMapPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquareVenue : NSObject

@property(nonatomic, strong) NSString *venueID;
@property(nonatomic, strong) NSString *name;
@property(nonatomic) float latitude;
@property(nonatomic) float longitude;
@property(nonatomic) int likes;

- (FourSquareVenue *) initWithID:(NSString *)venueID Name:(NSString *)name Latitude:(float)latitude Longitude:(float)longitude andLikes:(int)likeCount;

@end
