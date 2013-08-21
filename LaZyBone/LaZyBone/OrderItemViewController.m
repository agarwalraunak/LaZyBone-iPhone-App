//
//  OrderItemViewController.m
//  LaZyBone
//
//  Created by Lion User on 22/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "OrderItemViewController.h"
#import "LaZyOrderItem.h"
#import "LaZyRequest.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface OrderItemViewController ()

@end

@implementation OrderItemViewController

- (void)setDetailItem:(id)newDetailItem venue:(id)venue {
    _menuItem = newDetailItem;
    _venue = venue;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _uiUtil = [UIUtil getInstance];
    [_uiUtil beautifyViewBackground:self.view];
    for (UIView *view in [self.view subviews])
        [_uiUtil addShadowToView:view];
    
    _menuItemNameLabel.text = _menuItem.itemName;
    _menuItemDescTextView.text = _menuItem.description;
    _menuItemDescTextView.userInteractionEnabled = NO;
    
    _parsedPrice = [[FourSqAPI getInstance] parseIntValueOfPrice:_menuItem.price];
    
    _totalPriceLabel.text = [[NSString alloc] initWithFormat:@"$%.2f", _parsedPrice ];
    _priceLabel.text = _menuItem.price;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)decreaseQuantity:(id)sender {
    
    NSString *quantityStr = _quantityLabel.text;
    int quantity = [quantityStr intValue];
    if (quantity >1){
        --quantity;
        _quantityLabel.text = [[NSString alloc] initWithFormat:@"%d", quantity];
        _totalPriceLabel.text = [[NSString alloc] initWithFormat:@"$%.2f", _parsedPrice * quantity ];
    }
}

- (IBAction)increaseQuantity:(id)sender {
    NSString *quantityStr = _quantityLabel.text;
    int quantity = [quantityStr intValue];
    ++quantity;
    _quantityLabel.text = [[NSString alloc] initWithFormat:@"%d", quantity];
    _totalPriceLabel.text = [[NSString alloc] initWithFormat:@"$%.2f", _parsedPrice * quantity ];
}

- (IBAction)addToRequestAction:(id)sender {
    
    NSString *itemID = _menuItem.itemID;
    NSString *itemName = _menuItem.itemName;
    int quantity = [_quantityLabel.text integerValue];
    
    LaZyOrderItem *orderItem = [[LaZyOrderItem alloc] init];
    orderItem.itemID = itemID;
    orderItem.itemName = itemName;
    orderItem.price = _parsedPrice;
    orderItem.quantity = quantity;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    LaZyRequest *lrequest = appDelegate.request;

    if (!lrequest){
        LaZyRequest *request = [[LaZyRequest alloc] init];
        [request.orderItems addObject:orderItem];
        request.venue = _venue;
        
        PFUser *user = [PFUser currentUser];
        request.userId = user.username;
        
        appDelegate.request = request;
    }
    else{
        [lrequest removeOrderItemWithItemID:_menuItem.itemID];
        [lrequest.orderItems addObject:orderItem];
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Item was added successfully!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

@end