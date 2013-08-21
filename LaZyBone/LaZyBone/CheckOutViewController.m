//
//  CheckOutViewController.m
//  LaZyBone
//
//  Created by Lion User on 24/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "CheckOutViewController.h"
#import "AppDelegate.h"
#import "LaZyRequest.h"
#import <Parse/Parse.h>
#import "ServerRequest.h"
#import "LaZyOrderItem.h"
#import "UIUtil.h"

@interface CheckOutViewController ()

@end

@implementation CheckOutViewController

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
    _datePicker.hidden = YES;
    
    UIUtil *uiUtil = [UIUtil getInstance];
    [uiUtil beautifyViewBackground:self.view];
    
    for (UIView *view in [self.view subviews]){
        [uiUtil addShadowToView:view];
    }
    
    UIToolbar *numberToolbar = [uiUtil createNumberToolBarForTarget:self];
    _timeOfDelTextField.inputAccessoryView = numberToolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelNumberPad{
    [_timeOfDelTextField resignFirstResponder];
    _timeOfDelTextField.text = @"";
}

-(void)doneWithNumberPad{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    _timeOfDelTextField.text = [outputFormatter stringFromDate:_datePicker.date];

    [_timeOfDelTextField resignFirstResponder];
}


- (IBAction)checkOutRequest:(id)sender {
    
    NSString *delAddress1 = _delAddressLine1.text;
    NSString *delAddress2 = _delAddressLine2.text;
    NSString *delTime = _timeOfDelTextField.text;
    NSString *wage = _requestAmountTextField.text;
    
    if (delAddress1 == nil || delAddress1.length == 0 || delAddress2 == nil || delAddress2.length == 0
        || delTime == nil || delTime.length == 0 || wage == nil || wage.length == 0){
        _errorLabel.text = @"All Fields are required";
        _errorLabelHolder.hidden = NO;
        return;
    }
    
    _errorLabelHolder.hidden = YES;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    LaZyRequest *request = appDelegate.request;
    
    ServerRequest *data = [[ServerRequest alloc] init];
    
    PFUser *user = [PFUser currentUser];
    
    data.venueName = request.venue.name;
    data.delAddress = [[NSString alloc] initWithFormat:@"%@ %@", delAddress1, delAddress2];
    data.latitude = [[NSString alloc] initWithFormat:@"%f", request.venue.latitude ];
    data.longitude = [[NSString alloc] initWithFormat:@"%f", request.venue.longitude ];
    data.firstName = [user objectForKey:@"firstName"];
    data.lastName = [user objectForKey:@"lastName"];
    
    NSMutableString *orderItemStr = [[NSMutableString alloc] initWithFormat:@""];
    for (int i=0; i<[request.orderItems count]; i++){
        LaZyOrderItem *orderItem = [request.orderItems objectAtIndex:i];
        [orderItemStr appendFormat:@"%@||%.02f||%d", orderItem.itemName, orderItem.price, orderItem.quantity];
        if (i != request.orderItems.count-1){
            [orderItemStr appendFormat:@","];
        }
    }
    data.orderItems = orderItemStr;
    
    PFObject *requestData = [PFObject objectWithClassName:@"Request"];
    [requestData setObject:data.venueName forKey:@"venueName"];
    [requestData setObject:data.delAddress forKey:@"delAddress"];
    [requestData setObject:data.latitude forKey:@"latitude"];
    [requestData setObject:data.longitude forKey:@"longitude"];
    [requestData setObject:data.firstName forKey:@"firstName"];
    [requestData setObject:data.lastName forKey:@"lastName"];
    [requestData setObject:data.orderItems forKey:@"orderItems"];
    [requestData setObject:delTime forKey:@"deliveryTime"];
    [requestData setObject:user.username forKey:@"username"];
    [requestData setObject:wage forKey:@"wage"];
    
    [requestData save];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Your request was submitted Successfully" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_timeOfDelTextField]){
        textField.inputView = _datePicker;
        _datePicker.hidden = NO;
    }
    
    [[UIUtil getInstance] animateTextField:textField up:YES forView:self.view];

}


- (void) textFieldDidEndEditing:(UITextField *)textField{
    [[UIUtil getInstance] animateTextField:textField up:NO forView:self.view];
}
@end







