//
//  ViewController.h
//  LaZyBone
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUtil.h"

@interface LoginViewController : UIViewController
@property (strong, nonatomic) UIUtil *uiUtil;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *huskyIDTextField;
@property (strong, nonatomic) IBOutlet UILabel *validationErrorLabel;
@property (strong, nonatomic) IBOutlet UIView *validationErrorView;
@property (strong, nonatomic) IBOutlet UIView *activityIndicatorHolder;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)showRegisterationScreen:(id)sender;
- (IBAction)loginAction:(id)sender;
@end
