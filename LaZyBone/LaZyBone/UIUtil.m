//
//  UIUtil.m
//  LaZyBone
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import "UIUtil.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIUtil

static UIUtil *instance;

+ (UIUtil *) getInstance{
    if (!instance){
        @synchronized([UIUtil class]){
            if (!instance)
                instance = [[UIUtil alloc] init];
        }
    }
    return instance;
}

- (void) addShadowToView:(UIView *)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 12;
    view.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    view.layer.masksToBounds = NO;
}

- (UIToolbar *)createNumberToolBarForTarget:(id)target{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:target action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:target action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    return numberToolbar;
}

- (void) animateTextField: (UITextField *)textField up:(BOOL) up forView:(UIView *)view{
    
    CGFloat animatedDistance;
    
    static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
    static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
    static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
    static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
    static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
    
    CGRect textFieldRect = [view.window convertRect:textField.bounds fromView:textField];
    
    CGRect viewRect = [view.window convertRect:view.bounds fromView:view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
    CGFloat heightFraction = numerator/denominator;
    
    if (heightFraction < 0.0){
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0){
        heightFraction = 1.0;
    }

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown){
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else{
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = view.frame;
    
    animatedDistance = (up ? -animatedDistance : animatedDistance);
    
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (BOOL) validateUserTextInput:(NSString *)input{
    int asciiValue = 0;
    for (int i =0; i<[input length]; i++) {
        asciiValue = [input characterAtIndex:i];
        if (!((asciiValue>64 && asciiValue<91) || (asciiValue>96 && asciiValue<123))){
            return NO;
        }
    }
    return YES;
}

- (BOOL) validateUserNumberInput:(NSString *)input{
    int asciiValue = 0;
    for (int i =0; i<[input length]; i++) {
        asciiValue = [input characterAtIndex:i];
        if (!(asciiValue>47 && asciiValue<58)){
            return NO;
        }
    }
    return YES;
}

- (UIAlertView *)createAlertViewWithTitle:(NSString *)title Message:(NSString *)message delegate:(id)delegate andCancelTitle:(NSString *)cancelTitle{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    return alert;
}

- (void)beautifyActivityIndicator:(UIActivityIndicatorView *)activityIndicator andHolder:(UIView *)activityIndicatorHolder{
    activityIndicator.color = [UIColor whiteColor];
    activityIndicatorHolder.layer.cornerRadius = 5.0f;
}

- (void)beautifyViewBackground:(UIView *)view{
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue-fabric.png"]];
}

- (void)presentViewControllerFrom:(UIViewController *)from toWithIdentifier:(NSString *)identifier withTransition:(UIModalTransitionStyle)transition{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *HomeScreenViewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [HomeScreenViewController setModalTransitionStyle:transition];
    
    [from presentModalViewController:HomeScreenViewController animated:YES];
}
@end
