//
//  RegisterUserViewController.h
//  LaZyBone
//
//  Created by Lion User on 13/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUtil.h"

@interface RegisterUserViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UIAlertViewDelegate>
- (IBAction)displayLoginPage:(id)sender;
- (IBAction)registerUser:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *validationErrorLabel;
@property (strong, nonatomic) IBOutlet UIView *validationErrorView;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nuidTextField;
@property (strong, nonatomic) IBOutlet UITextField *huskyIDTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *imageView;
@property (strong, nonatomic) IBOutlet UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIUtil *uiUtil;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *activityIndicatorHolder;
- (IBAction)imagePickerAction:(id)sender;

@end
