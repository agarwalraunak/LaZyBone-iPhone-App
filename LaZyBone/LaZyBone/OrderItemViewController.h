//
//  OrderItemViewController.h
//  LaZyBone
//
//  Created by Lion User on 22/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "UIUtil.h"
#import "FourSqAPI.h"

@interface OrderItemViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *menuItemNameLabel;
@property (strong, nonatomic) MenuItem *menuItem;
@property (strong, nonatomic) FourSquareVenue *venue;
@property (strong, nonatomic) IBOutlet UITextView *menuItemDescTextView;
@property (strong, nonatomic) UIUtil *uiUtil;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
- (IBAction)decreaseQuantity:(id)sender;
- (IBAction)increaseQuantity:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic) float parsedPrice;
- (IBAction)addToRequestAction:(id)sender;
- (void)setDetailItem:(id)newDetailItem venue:(id)venue;

@end
