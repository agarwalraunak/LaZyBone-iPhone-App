//
//  AppDelegate.h
//  LaZyBone
//
//  Created by Lion User on 12/04/2013.
//  Copyright (c) 2013 Raunak Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LaZyRequest.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) LaZyRequest *request;

@end
