//
//  MenuItem.h
//  GoogleMapPOC
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property(nonatomic, strong)NSString *itemID;
@property(nonatomic, strong)NSString *itemName;
@property(nonatomic, strong)NSString *description;
@property(nonatomic, strong)NSString *price;

- (MenuItem *)initWithItemID:(NSString *)itemID itemName:(NSString *)itemName Price:(NSString *)price andDescription:(NSString *)description;

@end
