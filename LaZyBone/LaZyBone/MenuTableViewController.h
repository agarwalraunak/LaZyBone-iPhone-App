//
//  MenuTableViewController.h
//  LaZyBone
//
//  Created by Lion User on 22/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourSqAPI.h"
#import "MenuSection.h"
#import "MenuItem.h"

@interface MenuTableViewController : UITableViewController

@property(nonatomic, strong) FourSquareVenue *venue;
@property(nonatomic, strong) NSMutableArray *menuSectionList;


@end
