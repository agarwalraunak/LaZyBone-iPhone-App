//
//  UIUtil.h
//  LaZyBone
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtil : NSObject

+ (UIUtil *) getInstance;
- (void) addShadowToView:(UIView *)view;
- (UIToolbar *)createNumberToolBarForTarget:(id)target;
- (void) animateTextField: (UITextField *)textField up:(BOOL) up forView:(UIView *)view;
- (BOOL) validateUserTextInput:(NSString *)input;
- (BOOL) validateUserNumberInput:(NSString *)input;
- (UIAlertView *)createAlertViewWithTitle:(NSString *)title Message:(NSString *)message delegate:(id)delegate andCancelTitle:(NSString *)cancelTitle;
- (void)beautifyActivityIndicator:(UIActivityIndicatorView *)activityIndicator andHolder:(UIView *)activityIndicatorHolder;
- (void)beautifyViewBackground:(UIView *)view;
- (void)presentViewControllerFrom:(UIViewController *)from toWithIdentifier:(NSString *)identifier withTransition:(UIModalTransitionStyle)transition;
@end
