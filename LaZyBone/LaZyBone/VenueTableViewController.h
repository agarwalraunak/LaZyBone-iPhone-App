//
//  VenueTableViewController.h
//  LaZyBone
//
//  Created by Lion User on 18/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourSquareCategory.h"
#import "FourSqAPI.h"

@interface VenueTableViewController : UITableViewController

@property(strong, nonatomic)FourSquareCategory *category;
@property(strong, nonatomic)NSMutableArray *venues;
@property(strong, nonatomic)CLLocation *currentLocation;
@property(strong, nonatomic)NSMutableArray *searchResult;

@end
