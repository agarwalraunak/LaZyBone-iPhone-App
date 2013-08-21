//
//  MenuSection.m
//  GoogleMapPOC
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "MenuSection.h"

@implementation MenuSection

@synthesize sectionID = _sectionID, sectionName = _sectionName, menuItems = _menuItems;

- (MenuSection *)initWithSectionID:(NSString *)sectionID andSectionName:(NSString *)sectionName{
    self = [super init];
    self.sectionID = sectionID;
    self.sectionName = sectionName;
    self.menuItems = [[NSMutableArray alloc] init];
    return self;
}


@end
