//
//  LaZyOrderItem.m
//  LaZyBone
//
//  Created by Lion User on 23/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "LaZyOrderItem.h"

@implementation LaZyOrderItem

@synthesize itemID, itemName, price, quantity;

- (LaZyOrderItem *) initWithItemID:(NSString *)itemID itemName:(NSString *)itemName price:(float) price andQuantity:(int)quantity{
    self.itemID = itemID;
    self.itemName = itemName;
    self.price = price;
    self.quantity = quantity;
}

@end
