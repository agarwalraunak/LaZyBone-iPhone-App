//
//  RequestDetailViewController.m
//  LaZyBone
//
//  Created by Lion User on 25/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "RequestDetailViewController.h"
#import <Parse/Parse.h>
#import "LaZyOrderItem.h"
#import "CartCustomViewCell.h"
#import "UIUtil.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface RequestDetailViewController ()

@end

@implementation RequestDetailViewController

- (void) setDetailItem:(PFObject *) request{
    _request = request;
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
    _venueNameLabel.text = [_request valueForKey:@"venueName"];
    _wageLabel.text = [_request valueForKey:@"wage"];
    NSString *orderItemsStr = [_request valueForKey:@"orderItems"];
    NSArray *orderItems = [orderItemsStr componentsSeparatedByString:@","];
    
    _array = [[NSMutableArray alloc] init];
    for (NSString *orderItem in orderItems){
        NSArray *comp = [orderItem componentsSeparatedByString:@"||"];
        LaZyOrderItem *item = [[LaZyOrderItem alloc] init];
        item.itemName = [comp objectAtIndex:0];
        item.price = [[comp objectAtIndex:1] floatValue];
        item.quantity = [[comp objectAtIndex:2] integerValue];
        [_array addObject:item];
    }
    
    float total = 0.0;
    for (LaZyOrderItem *orderItem in _array){
        total += orderItem.price*orderItem.quantity;
    }
    _totalPriceLabel.text = [[NSString alloc] initWithFormat:@"%0.02f", total];
    
    UIUtil *uiUtil = [UIUtil getInstance];
    [uiUtil beautifyViewBackground:self.view];
    
    _delAddress.text = [_request objectForKey:@"delAddress"];
    
    for (UIView *view in [self.view subviews]){
        if (![view isEqual:_orderItemTable])
            [uiUtil addShadowToView:view];
    }
    
    self.orderItemTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickUpAction:(id)sender {

    NSString *orderItemsStr = [_request objectForKey:@"orderItems"];
    NSString *firstName = [_request objectForKey:@"firstName"];
    NSString *lastName = [_request objectForKey:@"lastName"];
    NSString *username = [_request objectForKey:@"username"];
    NSString *venueName = [_request objectForKey:@"venueName"];
    
    PFUser *user = [PFUser currentUser];
    NSString *currentUserFirstName = [user objectForKey:@"firstName"];
    NSString *currentUserLastName = [user objectForKey:@"lastName"];
    
    NSMutableString *mailBody = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"Hello %@ %@, \n\n",firstName, lastName]];
    
    [mailBody appendFormat:@"Your request of order from Venue %@ has been picked up by %@ %@ \n\n", venueName, currentUserFirstName, currentUserLastName];
    
    NSArray *orderItems = [orderItemsStr componentsSeparatedByString:@","];

    [mailBody appendFormat:@"Item Name\t\t"];
    [mailBody appendFormat:@"Price\t\t"];
    [mailBody appendFormat:@"Quantity\n"];
    [mailBody appendString:@"===================================================================\n"];
    
    for(NSString *item in orderItems)
    {
        NSArray *components = [item componentsSeparatedByString:@"||"];
        [mailBody appendFormat:@"%@\t", components[0]];
        [mailBody appendFormat:@"%@\t",components[1]];
        [mailBody appendFormat:@"%@\n",components[2]];
    }
    
    [mailBody appendFormat:@"\n\nSincerely Your's,\n\n LaZyBone.com\n\n\nPlease do not reply to this mail"];
    
    NSLog(@"%@",mailBody);
    
    NSLog(@"Send mail");
    
    
    SKPSMTPMessage *message = [[SKPSMTPMessage alloc] init];
    
    message.fromEmail = @"ssmartphonesfall12@gmail.com";
    
    message.toEmail =  [[NSString alloc] initWithFormat:@"%@@husky.neu.edu", username];
    
    message.relayHost = @"smtp.gmail.com";
    
    message.requiresAuth = YES;
    
    message.login = @"lazybone.com@gmail.com";
    
    message.pass = @"raunak123";
    
    message.subject = @"Request Picked";
    
    message.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    // Only do this for self-signed certs!
    
    // testMsg.validateSSLChain = NO;
    
    message.delegate = self;
    
    NSDictionary *plainText = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               
                               mailBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    //    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"sample.pdf\"",kSKPSMTPPartContentTypeKey,
    //
    //                             @"attachment;\r\n\tfilename=\"sample.pdf\"",kSKPSMTPPartContentDispositionKey,[dataObj encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    message.parts = [NSArray arrayWithObjects:plainText,
                     nil];
    
    [message send];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Request Picked Up Successfully" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
    
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
    return [_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CartCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell){
        cell = [[CartCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    LaZyOrderItem *orderItem = [_array objectAtIndex:indexPath.row];
    
    cell.menuItemLabel.text =  orderItem.itemName;
    cell.quantityLabel.text = [[NSString alloc] initWithFormat:@"%d",orderItem.quantity];
    cell.priceLabel.text = [[NSString alloc] initWithFormat:@"$%.02f", orderItem.price];
    cell.totalLabel.text = [[NSString alloc] initWithFormat:@"$%.02f", orderItem.price*orderItem.quantity];
    
//    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeOnCell:)];
//    gesture.direction = UISwipeGestureRecognizerDirectionRight;
//    [cell addGestureRecognizer:gesture];
    
    return cell;
}

-(void)messageSent:(SKPSMTPMessage *)message{
	
    NSLog(@"Message sent succesfully");
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
	
	// open an alert with just an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	
	NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}



@end
