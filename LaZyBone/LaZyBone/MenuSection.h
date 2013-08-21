//
//  MenuSection.h
//  GoogleMapPOC
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuSection : NSObject

@property(nonatomic, strong)NSString *sectionID;
@property(nonatomic, strong)NSString *sectionName;
@property(nonatomic, strong)NSMutableArray *menuItems;

- (MenuSection *)initWithSectionID:(NSString *)sectionID andSectionName:(NSString *)sectionName;

@end
