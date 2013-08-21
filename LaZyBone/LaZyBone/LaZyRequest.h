//
//  LaZyRequest.h
//  LaZyBone
//
//  Created by Lion User on 23/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FourSquareVenue.h"

@interface LaZyRequest : NSObject

@property(strong, nonatomic) NSString *userId;
@property(strong, nonatomic) FourSquareVenue *venue;
@property(strong, nonatomic) NSMutableArray *orderItems;
- (void) removeOrderItemWithItemID: (NSString *)itemID;


@end
