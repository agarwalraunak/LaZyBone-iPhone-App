//
//  CartViewController.h
//  LaZyBone
//
//  Created by Lion User on 24/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaZyRequest.h"

@interface CartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) IBOutlet UILabel *venueNameLabel;
@property(strong, nonatomic) LaZyRequest *request;

@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UITableView *orderItemTableView;

@end
