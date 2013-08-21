//
//  CartViewController.m
//  LaZyBone
//
//  Created by Lion User on 24/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "CartViewController.h"
#import "LaZyRequest.h"
#import "AppDelegate.h"
#import "LaZyOrderItem.h"
#import "UIUtil.h"
#import "CartCustomViewCell.h"

@interface CartViewController ()

@end

@implementation CartViewController

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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _request = appDelegate.request;
    _venueNameLabel.text = _request.venue.name;
    
    UIUtil *uiUtil = [UIUtil getInstance];
    [uiUtil beautifyViewBackground:self.view];
    for (UIView *view in [self.view subviews]){
        [uiUtil addShadowToView:view];
    }
    
    float totalPrice = 0.0;
    for (LaZyOrderItem *orderitem in _request.orderItems){
        totalPrice += orderitem.price*orderitem.quantity;
    }
    
    _totalPriceLabel.text = [[NSString alloc] initWithFormat:@"$%.02f", totalPrice];

    self.orderItemTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_request.orderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CartCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell){
        cell = [[CartCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    LaZyOrderItem *orderItem = [_request.orderItems objectAtIndex:indexPath.row];
    
    cell.menuItemLabel.text =  orderItem.itemName;
    cell.quantityLabel.text = [[NSString alloc] initWithFormat:@"%d",orderItem.quantity];
    cell.priceLabel.text = [[NSString alloc] initWithFormat:@"$%.02f", orderItem.price];
    cell.totalLabel.text = [[NSString alloc] initWithFormat:@"$%.02f", orderItem.price*orderItem.quantity];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeOnCell:)];
    gesture.direction = UISwipeGestureRecognizerDirectionRight;
    [cell addGestureRecognizer:gesture];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) handleSwipeOnCell:(UISwipeGestureRecognizer *) recognizer{
    UITableView *tableView = (UITableView *)[self.view viewWithTag:1];
    CGPoint location = [recognizer locationInView:tableView];
    NSIndexPath *swipedIndex = [tableView indexPathForRowAtPoint:location];
    [_request.orderItems removeObjectAtIndex:swipedIndex.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndex] withRowAnimation:YES];
    float totalPrice = 0.0;
    for (LaZyOrderItem *orderItem in _request.orderItems){
        totalPrice += orderItem.price*orderItem.quantity;
    }
    _totalPriceLabel.text = [[NSString alloc] initWithFormat:@"$%.02f", totalPrice];
}

@end