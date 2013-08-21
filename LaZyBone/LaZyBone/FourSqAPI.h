//
//  4sqAPI.h
//  4sqPOC
//
//  Created by Lion User on 11/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FourSquareCategory.h"
#import "FourSquareVenue.h"
#import <CoreLocation/CoreLocation.h>

@interface FourSqAPI : NSObject <CLLocationManagerDelegate>

+ (FourSqAPI *) getInstance;
- (void)getVenues;
- (NSMutableArray *) getVenuesForCategory: (FourSquareCategory *)category Location:(CLLocation *)location andRadius:(int)radius;
- (NSMutableArray *) getCategories;
- (NSMutableArray *) getMenuForVenue:(NSString *)venueID;
- (NSMutableArray *) getPicturesForVenue:(NSString *)venueID;
- (int) getLikesForVenue:(NSString *)venueID;
- (float) parseIntValueOfPrice:(NSString *)price;

@end
