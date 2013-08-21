//
//  LaZyOrderItem.h
//  LaZyBone
//
//  Created by Lion User on 23/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@interface LaZyOrderItem : NSObject

@property(nonatomic, strong)NSString *itemID;
@property(nonatomic, strong)NSString *itemName;
@property(nonatomic)float price;
@property(nonatomic)int quantity;

- (LaZyOrderItem *) initWithItemID:(NSString *)itemID itemName:(NSString *)itemName price:(float) price andQuantity:(int)quantity;

@end
