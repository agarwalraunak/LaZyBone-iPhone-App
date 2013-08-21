//
//  ViewController.m
//  LaZyBone
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _uiUtil = [UIUtil getInstance];
    
    [_uiUtil beautifyViewBackground:self.view];
    
    
    for (UIView *subView in [self.view subviews]){
        if (subView.tag != -1)
            [_uiUtil addShadowToView:subView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showRegisterationScreen:(id)sender {
    [_uiUtil presentViewControllerFrom:self toWithIdentifier:@"RegisterUserViewController" withTransition:UIModalTransitionStyleFlipHorizontal];
}

- (IBAction)loginAction:(id)sender {
    NSString *huskyID = [_huskyIDTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *password = [_passwordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (huskyID.length == 0 || password.length == 0){
        _validationErrorLabel.text = @"All fields are required";
        _validationErrorView.hidden = NO;
    }
    else{
        
        [_activityIndicator startAnimating];
        [_uiUtil beautifyActivityIndicator:_activityIndicator andHolder:_activityIndicatorHolder];
        _activityIndicatorHolder.hidden = NO;
        self.view.alpha = 0.5f;
        
        NSError *loginError = nil;
        [PFUser logInWithUsername:huskyID password:password error:&loginError];
        if (loginError){
            NSString *error = [[loginError userInfo] objectForKey:@"error"];
            _validationErrorLabel.text = error;
            _validationErrorView.hidden = NO;
            [_activityIndicator stopAnimating];
            _activityIndicatorHolder.hidden = YES;
            self.view.alpha = 1.0f;

        }
        else{
            [_uiUtil presentViewControllerFrom:self toWithIdentifier:@"HomeScreenViewController" withTransition:UIModalTransitionStyleCrossDissolve];
        }
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}
@end
