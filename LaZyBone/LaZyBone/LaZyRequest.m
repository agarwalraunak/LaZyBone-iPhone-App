//
//  LaZyRequest.m
//  LaZyBone
//
//  Created by Lion User on 23/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "LaZyRequest.h"
#import "LaZyOrderItem.h"

@implementation LaZyRequest

- (id)init
{
    self = [super init];
    if (self) {
        self.orderItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) removeOrderItemWithItemID: (NSString *)itemID{
    for (LaZyOrderItem *orderItem in _orderItems){
        if ([orderItem.itemID isEqual:itemID]){
            [_orderItems removeObject:orderItem];
            break;
        }
    }
}

@end
