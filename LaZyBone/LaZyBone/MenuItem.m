//
//  MenuItem.m
//  GoogleMapPOC
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

@synthesize itemID = _itemID, itemName = _itemName, price = _price, description = _description;

- (MenuItem *)initWithItemID:(NSString *)itemID itemName:(NSString *)itemName Price:(NSString *)price andDescription:(NSString *)description{
    self = [super init];
    self.itemID = itemID;
    self.itemName = itemName;
    self.price = price;
    self.description = description;
    return self;
}

@end
