//
//  CheckOutViewController.h
//  LaZyBone
//
//  Created by Lion User on 24/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutViewController : UIViewController
- (IBAction)checkOutRequest:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *delAddressLine1;
@property (strong, nonatomic) IBOutlet UITextField *delAddressLine2;

@property (strong, nonatomic) IBOutlet UITextField *timeOfDelTextField;
@property (strong, nonatomic) IBOutlet UITextField *requestAmountTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIView *errorLabelHolder;

@end
