//
//  WallTableViewController.h
//  LaZyBone
//
//  Created by Lion User on 25/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WallTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *objects;
@property (strong, nonatomic) CLLocation *currentLocation;

@end
