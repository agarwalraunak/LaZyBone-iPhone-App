//
//  RequestDetailViewController.h
//  LaZyBone
//
//  Created by Lion User on 25/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RequestDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *wageLabel;
@property (strong, nonatomic) PFObject *request;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) IBOutlet UILabel *delAddress;

@property (strong, nonatomic) IBOutlet UITableView *orderItemTable;
- (IBAction)pickUpAction:(id)sender;


@end
