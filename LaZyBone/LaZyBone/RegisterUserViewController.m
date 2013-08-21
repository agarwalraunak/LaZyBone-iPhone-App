//
//  RegisterUserViewController.m
//  LaZyBone
//
//  Created by Lion User on 13/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "RegisterUserViewController.h"
#import "UIUtil.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface RegisterUserViewController ()

@end

@implementation RegisterUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    _uiUtil = [UIUtil getInstance];
    [_uiUtil beautifyViewBackground:self.view];
    for (UIView *subView in [self.view subviews]){
        if (subView.tag != -1 || subView.tag != -2)
            [_uiUtil addShadowToView:subView];
    }
    UIView *imageView = [self.view viewWithTag:1];
    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"contactImgPlaceholder"]];
    
    UIToolbar *numberToolbar = [_uiUtil createNumberToolBarForTarget:self];
    _nuidTextField.inputAccessoryView = numberToolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelNumberPad{
    [_nuidTextField resignFirstResponder];
    _nuidTextField.text = @"";
}

-(void)doneWithNumberPad{
    [_nuidTextField resignFirstResponder];
}

- (IBAction)displayLoginPage:(id)sender {
    [_uiUtil presentViewControllerFrom:self toWithIdentifier:@"LoginViewController" withTransition:UIModalTransitionStyleFlipHorizontal];
}

- (IBAction)registerUser:(id)sender {
    NSString *firstName = [_firstNameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *lastName = [_lastNameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *nuid = [_nuidTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *huskyID = [_huskyIDTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *password = [_passwordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    UIImage *image = _imageView.currentBackgroundImage;
    
    _validationErrorLabel.text = @"";
    _validationErrorView.hidden = YES;
    
    if (firstName.length == 0 || lastName.length == 0 || nuid.length == 0 || huskyID.length == 0 || password == 0){
        _validationErrorLabel.text = @"All fields are required";
    }
    else if (![_uiUtil validateUserTextInput:firstName] || ![_uiUtil validateUserTextInput:lastName]){
        _validationErrorLabel.text = @"Only Alphabets are allowed for First and Last Name";
    }
    else if (![_uiUtil validateUserNumberInput:nuid]){
        _validationErrorLabel.text = @"Only Numbers are allowed for NUID";
    }
    if (_validationErrorLabel.text.length != 0){
        _validationErrorView.hidden = NO;
        return;
    }
    
    [_activityIndicator startAnimating];
    [_uiUtil beautifyActivityIndicator:_activityIndicator andHolder:_activityIndicatorHolder];
    _activityIndicatorHolder.hidden = NO;
    self.view.alpha = 0.5f;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *imagePath = [documentsPath stringByAppendingFormat:@"/%@.png",huskyID]; //Add the file name
    
    //Writing the image to a file
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:imagePath atomically:YES];
    
    //Saving the Data on the Server
    PFUser *user = [PFUser user];
    user.username = huskyID;
    user.password = password;
    user.email = [[NSString alloc] initWithFormat:@"%@%@", huskyID, @"@husky.neu.edu" ];
    [user setObject:firstName forKey:@"firstName"];
    [user setObject:lastName forKey:@"lastName"];
    [user setObject:nuid forKey:@"nuid"];
    [user setObject:imagePath forKey:@"image"];
    
    NSError *signUpError = nil;
    [user signUp:&signUpError];
    if (signUpError){
        NSString *error = [[signUpError userInfo] objectForKey:@"error"];
        _validationErrorLabel.text = error;
        _validationErrorView.hidden = NO;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registered Successfully!" message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
    self.view.alpha = 1;
    [_activityIndicator stopAnimating];
    _activityIndicatorHolder.hidden = YES;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self displayLoginPage:nil];
}

- (IBAction)imagePickerAction:(id)sender {
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.allowsEditing = YES;
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_imageView setBackgroundImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
    _imageView.titleLabel.text = @"";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    [_uiUtil animateTextField:textField up:YES forView:self.view];
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
       [_uiUtil animateTextField:textField up:NO forView:self.view];
}


@end
