//
//  CartCustomViewCell.h
//  LaZyBone
//
//  Created by Lion User on 24/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCustomViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *menuItemLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;

@end
